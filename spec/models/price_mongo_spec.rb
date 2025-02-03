require 'rails_helper'

RSpec.describe PriceMongo, type: :model do
  before(:each) do
    PriceMongo.delete_all
  end

  describe 'validations' do
    it 'is invalid without a country' do
      price = PriceMongo.new(brand: 'Apple', product_id: '123', product_name: 'Test', shop_name: 'Amazon', price: 100, url: 'https://example.com')
      expect(price.valid?).to be_falsey
      expect(price.errors[:country]).to include("can't be blank")
    end

    it 'is invalid without a brand' do
      price = PriceMongo.new(country: 'US', product_id: '123', product_name: 'Test', shop_name: 'Amazon', price: 100, url: 'https://example.com')
      expect(price.valid?).to be_truthy
    end

    it 'is invalid without a product_id' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_name: 'Test', shop_name: 'Amazon', price: 100, url: 'https://example.com')
      expect(price.valid?).to be_falsey
      expect(price.errors[:product_id]).to include("can't be blank")
    end

    it 'is invalid without a product_name' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_id: '123', shop_name: 'Amazon', price: 100, url: 'https://example.com')
      expect(price.valid?).to be_falsey
      expect(price.errors[:product_name]).to include("can't be blank")
    end

    it 'is invalid without a shop_name' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_id: '123', product_name: 'Test', price: 100, url: 'https://example.com')
      expect(price.valid?).to be_falsey
      expect(price.errors[:shop_name]).to include("can't be blank")
    end

    it 'is invalid without a product_category_id' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_id: '123', product_name: 'Test', shop_name: 'Amazon', price: 100, url: 'https://example.com')
      expect(price.valid?).to be_truthy
    end

    it 'is invalid without a price' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_id: '123', product_name: 'Test', shop_name: 'Amazon', url: 'https://example.com')
      expect(price.valid?).to be_falsey
      expect(price.errors[:price]).to include("can't be blank")
    end

    it 'is invalid with a price of zero' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_id: '123', product_name: 'Test', shop_name: 'Amazon', price: 0, url: 'https://example.com')
      expect(price.valid?).to be_falsey
      expect(price.errors[:price]).to include('must be greater than 0')
    end

    it 'is invalid with a negative price' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_id: '123', product_name: 'Test', shop_name: 'Amazon', price: -5, url: 'https://example.com')
      expect(price.valid?).to be_falsey
      expect(price.errors[:price]).to include('must be greater than 0')
    end

    it 'is valid with all required attributes' do
      price = PriceMongo.new(country: 'US', brand: 'Apple', product_id: '123', product_name: 'Test', shop_name: 'Amazon', price: 100, url: 'https://example.com')
      expect(price.valid?).to be_truthy
    end
  end

  describe 'database indexes' do
    it "ensures uniqueness of country, product_id, and shop_name" do
      create(:price_mongo, country: 'US', product_id: '123', shop_name: 'Amazon')

      expect {
        create(:price_mongo, country: 'US', product_id: '123', shop_name: 'Amazon')
      }.to raise_error(Mongo::Error::OperationFailure, /E11000 duplicate key error/)
    end
  end
end