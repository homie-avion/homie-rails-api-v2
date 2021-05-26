class StayPeriod < ApplicationRecord
  has_many :properties

  validates :name, presence: true

  has_many :stay_period_preferences
  has_many :users, through: :stay_period_preferences
end
