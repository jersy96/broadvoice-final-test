class ProductSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :cost
end