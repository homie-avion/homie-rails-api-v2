class Role < ApplicationRecord
  
  has_many :users

  validates :name, inclusion: { in: ["partner", "user"], message: "%{value} is not a valid role" }

  #scoping
  scope :users, -> { where(name: "user") }
  scope :partners, -> { where(name: "partner") }
end
