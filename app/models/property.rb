class Property < ApplicationRecord
  paginates_per 10

  validates :name, presence: true

  validates :tenant_count, :property_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :homie_value, :cost_living_index, :flood_index, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  # validates :status, presence: true

  #
  belongs_to :user
  # belongs_to :property
  
  has_many :chats, dependent: :destroy
  has_many :transactions, dependent: :destroy

  belongs_to :city
  belongs_to :rent
  belongs_to :stay_period
  belongs_to :property_type
end
