class Sale < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :salesperson, class_name: 'User'
  has_and_belongs_to_many :products
end
