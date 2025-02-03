class PriceMongo
  include Mongoid::Document

  field :country, type: String
  field :brand, type: String
  field :product_id, type: String
  field :product_name, type: String
  field :shop_name, type: String
  field :product_category_id, type: String
  field :price, type: Float
  field :url, type: String

  validates :country, :product_id, :product_name, :shop_name, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  index({ country: 1, product_id: 1, shop_name: 1 }, unique: true)
end