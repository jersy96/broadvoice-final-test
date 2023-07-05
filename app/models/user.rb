class User < ApplicationRecord
  has_many :sales
  enum role: { salesperson: 0, customer: 1 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "role", "updated_at"]
  end
end
