class Product < ApplicationRecord
  has_many :sales

  def self.ransackable_attributes(auth_object = nil)
    ["code", "cost", "created_at", "id", "name", "updated_at"]
  end
end
