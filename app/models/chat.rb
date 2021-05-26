class Chat < ApplicationRecord
  validates :success, inclusion: [true, false]

  belongs_to :property
  has_many :messages, dependent: :nullify

  belongs_to :user, class_name: "User"
  belongs_to :partner, class_name: "User"  

end
