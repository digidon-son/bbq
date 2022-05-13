class Event < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :subscriptions

  validates :user, presence: true
  validates :address, presence: true
  validates :datetime, presence: true
  validates :title, presence: true, length: { maximum: 255 }
end
