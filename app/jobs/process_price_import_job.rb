class ProcessPriceImportJob
  include Sidekiq::Job

  # Uncomment the following lines when using Sidekiq Pro/Enterprise
  # BATCH_SIZE = 1000

  def perform(json_data)
    Rails.logger.info "Starting JSON processing"

    begin
      data = JSON.parse(json_data)
      Rails.logger.info "JSON parsed successfully. Total records: #{data.size}"

      # Implementation for Sidekiq Free
      data.each do |entry|
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

      # Sidekiq Pro/Enterprise Implementation (commented out)
      # batch = Sidekiq::Batch.new
      # batch.description = "Processing #{data.size} price records"
      #
      # batch.on(:complete, 'ProcessPriceImportJob#on_complete')
      # batch.on(:success, 'ProcessPriceImportJob#on_success')
      # batch.on(:failure, 'ProcessPriceImportJob#on_failure')
      #
      # batch.jobs do
      #   data.each_slice(BATCH_SIZE) do |batch_data|
      #     ProcessPriceBatchJob.perform_async(batch_data.to_json)
      #   end
      # end

    rescue JSON::ParserError => e
      Rails.logger.error "Error processing JSON in Job: #{e.message}"
      raise
    rescue StandardError => e
      Rails.logger.error "Unexpected error: #{e.message}"
      raise
    end
  end

  # Callback methods for Sidekiq Pro/Enterprise batch processing
  # def on_complete(status, options)
  #   Rails.logger.info "Batch #{status.bid} completed"
  # end
  #
  # def on_success(status, options)
  #   Rails.logger.info "Batch #{status.bid} succeeded, processed #{status.total} jobs"
  # end
  #
  # def on_failure(status, options)
  #   Rails.logger.error "Batch #{status.bid} failed, #{status.failures} jobs failed"
  # end

  private

  def sanitize(value)
    return unless value
    value.gsub(/\b(BE|NL|FR|PT)\b/, "").strip
  end
end
