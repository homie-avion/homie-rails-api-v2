class CityPreference < ApplicationRecord
  belongs_to :user
  belongs_to :city
end
