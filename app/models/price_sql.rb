class PriceSql < ApplicationRecord
  self.table_name = "price_sqls"

  validates :product_name, :country, :product_id, :shop_name, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true

  validates :product_id, uniqueness: { scope: %i[country shop_name] }
end