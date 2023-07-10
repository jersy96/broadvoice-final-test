class Sale < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :salesperson, class_name: 'User'
  belongs_to :product
  
  def self.ransackable_attributes(auth_object = nil)
    ["city", "created_at", "customer_id", "id", "product_id", "salesperson_id", "state", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "salesperson", "product"]
  end

  def calculate_profit
    return nil if price.blank?
    price - product.cost
  end
end