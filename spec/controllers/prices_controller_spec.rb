require 'rails_helper'

RSpec.describe PricesController, type: :controller do
  describe 'GET #index' do
    let!(:price1) { create(:price_sql, country: 'BR', price: 100) }
    let!(:price2) { create(:price_sql, country: 'US', price: 50) }

    context 'when no country filter is provided' do
      it 'returns all prices ordered by price' do
        get :index

        expect(response).to have_http_status(:ok)
        prices = JSON.parse(response.body)
        expect(prices.map { |p| p['price'].to_f }).to eq([50.0, 100.0])
      end
    end

    context 'when country filter is provided' do
      it 'returns prices for specific country' do
        get :index, params: { country: 'BR' }

        expect(response).to have_http_status(:ok)
        prices = JSON.parse(response.body)
        expect(prices.length).to eq(1)
        expect(prices.first['country']).to eq('BR')
      end
    end
  end

  describe 'GET #show' do
    context 'when price exists' do
      let!(:price) { create(:price_sql, country: 'BR') }

      it 'returns the price' do
        get :show, params: { country: 'BR' }

        expect(response).to have_http_status(:ok)
        price_response = JSON.parse(response.body)
        expect(price_response['country']).to eq('BR')
      end
    end

    context 'when price does not exist' do
      it 'returns not found status' do
        get :show, params: { country: 'XX' }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Price not found')
      end
    end
  end

  describe 'POST #create' do
    let(:valid_json) { [{ country: 'BR', price: 100 }].to_json }

    context 'with valid JSON data' do
      it 'enqueues import job and returns accepted status' do
        expect(ProcessPriceImportJob).to receive(:perform_async).with(valid_json)

        post :create, body: valid_json

        expect(response).to have_http_status(:accepted)
        expect(JSON.parse(response.body)['message']).to eq('Import started')
      end
    end

    context 'with no JSON data' do
      it 'returns unprocessable entity status' do
        post :create, body: ''

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('No JSON found')
      end
    end

    context 'with invalid JSON data' do
      it 'returns unprocessable entity status' do
        post :create, body: 'invalid json'

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('JSON process failed')
      end
    end

    context 'with empty JSON array' do
      it 'returns unprocessable entity status' do
        post :create, body: '[]'

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Empty JSON')
      end
    end
  end
end