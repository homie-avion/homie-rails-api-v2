class Post < ApplicationRecord
  #
  validates :name, presence: true
  validates :rent_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :length_of_stay, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tenant_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :homie_value, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, default: 5
  validates :cost_living_index, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, default: 5
  validates :flood_index, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, default: 5

  validates :status, presence: true

  #
  belongs_to :landlord, class_name: "User"
  belongs_to :property
  has_many :chats, dependent: :nullify
  has_one :city, dependent: :nullify

end
