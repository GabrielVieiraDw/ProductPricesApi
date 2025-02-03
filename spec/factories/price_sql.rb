FactoryBot.define do
  factory :price_sql do
    country { 'US' }
    brand { 'Apple' }
    product_id { '12345' }
    product_name { 'iPhone' }
    shop_name { 'Amazon' }
    product_category_id { '1' }
    price { 999.99 }
    url { 'https://example.com' }
  end
end