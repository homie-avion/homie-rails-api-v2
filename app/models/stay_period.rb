class StayPeriod < ApplicationRecord
  has_many :properties

  validates :name, presence: true

  has_many :rent_preferences
  has_many :users, through: :rent_preferences
end
