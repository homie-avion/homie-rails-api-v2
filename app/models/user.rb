class User < ApplicationRecord
  validates :username, :password_digest, :email, presence: true
  validates :email, uniqueness: true
  validates :password_digest, length: { minimum: 6 }
  validates :approved, inclusion: { in: [true, false] }
  # validates :password_digest, with: /^[A-Za-z0-9]+$/

  has_secure_password

  belongs_to :role
  has_many :properties, dependent: :nullify
  has_many :chats
  has_many :user, class_name: "Chat", foreign_key: "user_id", dependent: :nullify
  has_many :partner, class_name: "Chat", foreign_key: "partner_id", dependent: :nullify
  
  has_many :city_preferences
  has_many :cities, through: :city_preferences


  # scoping
  scope :partners, -> { joins(:role).merge(Role.partners) }
  scope :users, -> { joins(:role).merge(Role.users) }

  scope :unapproved_partners, -> { partners.where(approved: false) }
  scope :unapproved_partners_count, -> { partners.where(approved: false).count }

  scope :cities_preferred, -> {city_preferences.pluck(:city_id)}
end
