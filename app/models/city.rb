class City < ApplicationRecord

  has_many :properties

  validates :name, presence: true

  has_many :city_preferences
  has_many :users, through: :city_preferences
end
