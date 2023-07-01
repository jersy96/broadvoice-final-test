require 'faker'

100.times do |count|
  User.create(
    role: :salesperson,
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
  )
  User.create(
    role: :customer,
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
  )
  puts "users count: #{count}"
end

1_000.times do |count|
  Product.create(
    code: Faker::Alphanumeric.unique.alphanumeric(number: 6).upcase,
    name: Faker::Commerce.unique.product_name,
    cost: Faker::Commerce.price(range: 0..100.0, as_string: false)
  )
  puts "products count: #{count}"
end

year = 2023
(1..6).to_a.each do |month|
  10_000.times do |count|
    date = Faker::Date.between(from: "#{year}-#{month}-01", to: "#{year}-#{month}-28")
    hour = Faker::Number.between(from: 0, to: 23)
    minute = Faker::Number.between(from: 0, to: 59)
    second = Faker::Number.between(from: 0, to: 59)
    Sale.create(
      customer: User.where(role: :customer).sample,
      salesperson: User.where(role: :salesperson).sample,
      product: Product.all.sample,
      city: Faker::Address.city,
      state: Faker::Address.state,
      created_at: DateTime.new(date.year, date.month, date.day, hour, minute, second),
    )
    puts "sales count: #{month} - #{count}" if count % 1000 == 0
  end
end