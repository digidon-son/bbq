# frozen_string_literal: true

# Класс подписок на событие
class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }

  validate :email_in_use

  validate :organizer_cant_subscribe

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def email_in_use
    errors.add(:user_email, :busy) if User.where(email: user_email.downcase).exists?
  end

  def organizer_cant_subscribe
    errors.add(:user, :organizer) if user == event.user
  end
end
