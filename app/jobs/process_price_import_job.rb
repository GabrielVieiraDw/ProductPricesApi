class ProcessPriceImportJob
  include Sidekiq::Job

  def perform(json_data)
    Rails.logger.info "Starting JSON processing"

    begin
      data = JSON.parse(json_data)
      Rails.logger.info "JSON parsed successfully. Total records: #{data.size}"

      data.find_each(batch_size: 1000) do |entry|
        next unless entry["availability"] && entry["price"].to_f > 0

        price_data = {
          country: sanitize(entry["country"]),
          brand: entry["brand"],
          product_id: entry["sku"],
          product_name: entry["model"],
          shop_name: sanitize(entry["site"] || entry["marketplaceseller"]),
          product_category_id: entry["categoryId"],
          price: entry["price"],
          url: entry["url"]
        }

        result_sql = PriceSql.upsert(price_data, unique_by: [:country, :product_id, :shop_name])

        result_mongo = PriceMongo.create(price_data)
      end

    rescue JSON::ParserError => e
      Rails.logger.error "Error processing JSON in Job: #{e.message}"
      raise
    rescue StandardError => e
      Rails.logger.error "Unexpected error: #{e.message}"
      raise
    end
  end

  private

  def sanitize(value)
    return unless value
    value.gsub(/\b(BE|NL|FR|PT)\b/, "").strip
  end
end
