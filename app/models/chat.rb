class Chat < ApplicationRecord
  validates :success, inclusion: [true, false]

  belongs_to :post
  has_many :messages, dependent: :nullify

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"  

end
