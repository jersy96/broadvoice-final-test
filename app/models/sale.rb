class Sale < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :salesperson, class_name: 'User'
  belongs_to :product
end