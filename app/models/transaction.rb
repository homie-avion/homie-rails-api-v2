class Transaction < ApplicationRecord

  belongs_to :partner, class_name: "User"
  belongs_to :user, class_name: "User"
  belongs_to :post

end
