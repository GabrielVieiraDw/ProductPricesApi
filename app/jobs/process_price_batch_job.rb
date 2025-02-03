# Uncomment and use this job when using Sidekiq Pro/Enterprise
#
# class ProcessPriceBatchJob
#   include Sidekiq::Job
#
#   def perform(batch_json_data)
#     data = JSON.parse(batch_json_data)
#
#     data.each do |entry|
#       next unless entry["availability"] && entry["price"].to_f > 0
#
#       price_data = {
#         country: sanitize(entry["country"]),
#         brand: entry["brand"],
#         product_id: entry["sku"],
#         product_name: entry["model"],
#         shop_name: sanitize(entry["site"] || entry["marketplaceseller"]),
#         product_category_id: entry["categoryId"],
#         price: entry["price"],
#         url: entry["url"]
#       }
#
#       result_sql = PriceSql.upsert(price_data, unique_by: [:country, :product_id, :shop_name])
#       result_mongo = PriceMongo.create(price_data)
#     end
#   end
#
#   private
#
#   def sanitize(value)
#     return unless value
#     value.gsub(/\b(BE|NL|FR|PT)\b/, "").strip
#   end
# end