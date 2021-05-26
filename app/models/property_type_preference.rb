class PropertyTypePreference < ApplicationRecord
  belongs_to :user
  belongs_to :property_type
end
