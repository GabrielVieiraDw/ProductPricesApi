require 'rails_helper'

RSpec.describe PriceSql, type: :model do
  subject { described_class.new(country: "US", product_id: "123", product_name: "Laptop", shop_name: "Amazon", price: 100) }

  describe 'validations' do
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:product_name) }
    it { should validate_presence_of(:shop_name) }
    it { should validate_presence_of(:price) }

    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe 'database indexes' do
    it 'ensures uniqueness of country, product_id, and shop_name' do
      create(:price_sql, country: 'US', product_id: '123', shop_name: 'Amazon')
      duplicate = build(:price_sql, country: 'US', product_id: '123', shop_name: 'Amazon')

      expect(duplicate.valid?).to be_falsey
      expect(duplicate.errors[:product_id]).to include('has already been taken')
    end
  end
end