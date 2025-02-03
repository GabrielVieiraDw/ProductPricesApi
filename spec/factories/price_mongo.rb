FactoryBot.define do
  factory :price_mongo do
    country { "US" }
    brand { "Apple" }
    product_id { "12345" }
    product_name { "iPhone 14" }
    shop_name { "Amazon" }
    product_category_id { "mobile-phones" }
    price { 999.99 }
    url { "https://example.com/product/12345" }
  end
end