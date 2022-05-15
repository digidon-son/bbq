class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }

  validate :email_in_use

  validate :organizer_cant_subscribe

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def email_in_use
    if User.where("email = ?", self.user_email.downcase).first
      errors.add(:user_email, 'занят')
    end
  end

  def organizer_cant_subscribe
    errors.add(:organizer, I18n.t('controllers.subscriptions.organizer')) if user == event.user
  end
end