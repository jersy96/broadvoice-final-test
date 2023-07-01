class SaleSerializer < ActiveModel::Serializer
  attributes :id, :salesperson, :customer, :product, :city, :state, :created_at

  def salesperson
    UserSerializer.new(object.salesperson)
  end

  def customer
    UserSerializer.new(object.customer)
  end

  def product
    ProductSerializer.new(object.product)
  end
end
