class Role < ApplicationRecord
  
  validates :name, presence: true, inclusion: { in: ["partner", "user"], message: "%{value} is not a valid role" }
  
  has_many :users, dependent: :nullify
  
  #scoping
  scope :users, -> { where(name: "user") }
  scope :partners, -> { where(name: "partner") }
end
