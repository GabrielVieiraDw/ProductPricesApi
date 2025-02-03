class PricesController < ApplicationController
  before_action :set_prices, only: [:index]

  def index
    prices = @prices.order(price: :asc).page(params[:page]).per(20)
    render json: prices
  end

  def show
    @price = PriceSql.find_by!(country: params[:country])
    render json: @price
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Price not found" }, status: :not_found
  end

  def create
    json_data = request.raw_post

    if json_data.blank?
      return render json: { error: "No JSON found" }, status: :unprocessable_entity
    end

    begin
      parsed_data = JSON.parse(json_data)
    rescue JSON::ParserError
      return render json: { error: "JSON process failed" }, status: :unprocessable_entity
    end

    if parsed_data.empty?
      return render json: { error: "Empty JSON" }, status: :unprocessable_entity
    end

    # TODO: Upload file to S3 and send S3 link
    ProcessPriceImportJob.perform_async(parsed_data.to_json)

    render json: { message: "Import started" }, status: :accepted
  end

  private

  def set_prices
    @prices = params[:country].present? ? PriceSql.where(country: params[:country]) : PriceSql.all
  end
end