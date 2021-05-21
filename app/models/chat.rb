class Chat < ApplicationRecord

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :post
  has_many :messages, dependent: :nullify

  validates :success, inclusion: [true, false], default: false

end
