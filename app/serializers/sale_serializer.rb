class SaleSerializer < ActiveModel::Serializer
  attributes :id, :salesperson, :customer, :product, :city, :state, :price, :created_at, :profit

  def salesperson
    UserSerializer.new(object.salesperson)
  end

  def customer
    UserSerializer.new(object.customer)
  end

  def product
    ProductSerializer.new(object.product)
  end

  def profit
    object.calculate_profit
  end
end
