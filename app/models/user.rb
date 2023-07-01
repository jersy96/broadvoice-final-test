class User < ApplicationRecord
  has_many :sales

  enum role: { salesperson: 0, customer: 1 }
end
