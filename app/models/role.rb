class Role < ApplicationRecord
  
  has_many :users

  validates :name, inclusion: { in: ["tenant", "landlord"], message: "%{value} is not a valid role" }
end
