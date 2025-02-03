require 'rails_helper'

RSpec.describe ProcessPriceImportJob, type: :job do
  describe '#perform' do
    let(:valid_json_data) do
      [
        {
          "availability" => true,
          "country" => "BE France",
          "brand" => "Samsung",
          "sku" => "12345",
          "model" => "Galaxy S21",
          "site" => "Amazon BE",
          "categoryId" => "smartphones",
          "price" => "999.99",
          "url" => "http://example.com/product"
        }
      ].to_json
    end

    let(:invalid_json_data) { 'invalid json' }

    context 'when processing valid JSON data' do
      it 'processes the data and creates records' do
        expect(PriceSql).to receive(:upsert).with(
          {
            country: "France",
            brand: "Samsung",
            product_id: "12345",
            product_name: "Galaxy S21",
            shop_name: "Amazon",
            product_category_id: "smartphones",
            price: "999.99",
            url: "http://example.com/product"
          },
          unique_by: [:country, :product_id, :shop_name]
        )

        expect(PriceMongo).to receive(:create).with(
          {
            country: "France",
            brand: "Samsung",
            product_id: "12345",
            product_name: "Galaxy S21",
            shop_name: "Amazon",
            product_category_id: "smartphones",
            price: "999.99",
            url: "http://example.com/product"
          }
        )

        ProcessPriceImportJob.new.perform(valid_json_data)
      end

      it 'skips records with availability false' do
        json_data = [
          {
            "availability" => false,
            "price" => "999.99"
          }
        ].to_json

        expect(PriceSql).not_to receive(:upsert)
        expect(PriceMongo).not_to receive(:create)

        ProcessPriceImportJob.new.perform(json_data)
      end

      it 'skips records with price zero' do
        json_data = [
          {
            "availability" => true,
            "price" => "0"
          }
        ].to_json

        expect(PriceSql).not_to receive(:upsert)
        expect(PriceMongo).not_to receive(:create)

        ProcessPriceImportJob.new.perform(json_data)
      end
    end

    context 'when processing invalid JSON data' do
      it 'raises JSON::ParserError' do
        expect {
          ProcessPriceImportJob.new.perform(invalid_json_data)
        }.to raise_error(JSON::ParserError)
      end
    end
  end

  describe '#sanitize' do
    let(:job) { ProcessPriceImportJob.new }

    it 'removes country codes and strips whitespace' do
      expect(job.send(:sanitize, "BE Amazon NL")).to eq("Amazon")
      expect(job.send(:sanitize, "FR Store PT")).to eq("Store")
    end

    it 'returns nil for nil input' do
      expect(job.send(:sanitize, nil)).to be_nil
    end
  end
end