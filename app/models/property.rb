class Property < ApplicationRecord

  has_many :posts, dependent: :nullify

  validates :name, inclusion: { in: ["condominium", "townhouse", "apartment"], message: "%{value} is not a valid user" }

end
