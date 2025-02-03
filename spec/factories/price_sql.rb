FactoryBot.define do
  factory :price_sql do
    sequence(:country) { |n| "Country#{n}" }
    sequence(:product_id) { |n| "PROD-#{n}" }
    sequence(:product_name) { |n| "Product #{n}" }
    sequence(:shop_name) { |n| "Shop #{n}" }
    price { rand(1..1000) }
    brand { "Test Brand" }
    product_category_id { "1" }
    url { "https://example.com" }
  end
end