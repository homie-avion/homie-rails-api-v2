class User < ApplicationRecord
  validates :username, :password_digest, :email, presence: true
  validates :email, uniqueness: true
  validates :password_digest, length: { minimum: 6 }
  # validates :password_digest, with: /^[A-Za-z0-9]+$/

  has_secure_password

  belongs_to :role
  has_many :posts, dependent: :nullify
  has_many :chats
  has_many :senders, class_name: "Chat", foreign_key: "sender_id", dependent: :nullify
  has_many :receiver, class_name: "Chat", foreign_key: "receiver_id", dependent: :nullify
  
end
