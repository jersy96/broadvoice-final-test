require 'faker'

# 100 salespersons *
# 100 customer *
# 1_000 products
# 10_000 sales per month


# 100.times do
#   User.create(
#     role: :salesperson,
#     name: Faker::Name.name,
#     email: Faker::Internet.unique.email,
#   )
#   User.create(
#     role: :customer,
#     name: Faker::Name.name,
#     email: Faker::Internet.unique.email,
#   )
# end

# 1_000.times do
#   Product.create(
#     code: Faker::Alphanumeric.unique.alphanumeric(number: 6).upcase,
#     name: Faker::Commerce.unique.product_name,
#     cost: Faker::Commerce.price(range: 0..100.0, as_string: false)
#   )
# end

# year = 2023
# (1..6).to_a.each do |month|
#   10_000.times do
#     date = Faker::Date.between(from: "#{year}-#{month}-01", to: "#{year}-#{month}-28")
#     hour = Faker::Number.between(from: 0, to: 23)
#     minute = Faker::Number.between(from: 0, to: 59)
#     second = Faker::Number.between(from: 0, to: 59)
#     Sale.create(
#       customer: User.where(role: :customer).sample,
#       salesperson: User.where(role: :salesperson).sample,
#       city: Faker::Address.city,
#       state: Faker::Address.state,
#       created_at: DateTime.new(date.year, date.month, date.day, hour, minute, second)
#     )
#   end
# end

# User.create(
#   role: :salesperson,
#   name: Faker::Name.name,
#   email: Faker::Internet.unique.email,
# )
# User.create(
#   role: :customer,
#   name: Faker::Name.name,
#   email: Faker::Internet.unique.email,
# )
Product.create(
  code: Faker::Alphanumeric.unique.alphanumeric(number: 6).upcase,
  name: Faker::Commerce.unique.product_name,
  cost: Faker::Commerce.price(range: 0..100.0, as_string: false)
)
year = 2023
month = 6
date = Faker::Date.between(from: "#{year}-#{month}-01", to: "#{year}-#{month}-28")
hour = Faker::Number.between(from: 0, to: 23)
minute = Faker::Number.between(from: 0, to: 59)
second = Faker::Number.between(from: 0, to: 59)
num_products = Faker::Number.between(from: 1, to: 5)
products = Product.all.sample(num_products)
Sale.create(
  customer: User.where(role: :customer).sample,
  salesperson: User.where(role: :salesperson).sample,
  city: Faker::Address.city,
  state: Faker::Address.state,
  products: products,
  created_at: DateTime.new(date.year, date.month, date.day, hour, minute, second),
)
