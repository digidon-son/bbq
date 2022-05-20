# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos

  validates :user, presence: true
  validates :address, presence: true
  validates :datetime, presence: true
  validates :title, presence: true, length: { maximum: 255 }

  def visitors
    (subscribers + [user]).uniq
  end

  def pincode_valid?(pin2check)
    pincode == pin2check
  end
end
