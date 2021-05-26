class PropertyType < ApplicationRecord
  has_many :properties

  validates :name, presence: true

  has_many :property_type_preferences
  has_many :users, through: :property_type_preferences
end
