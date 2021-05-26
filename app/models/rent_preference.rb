class RentPreference < ApplicationRecord
  belongs_to :user
  belongs_to :rent
end
