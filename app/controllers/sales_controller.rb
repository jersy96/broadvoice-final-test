class SalesController < ApplicationController
  def index
    @sales = SaleService::Index.new(
      page: params[:page], per_page: params[:per_page],
      search_term: params[:search_term], start_date: params[:start_date],
      end_date: params[:end_date]
    ).call
    render status: :ok, json: @sales, each_serializer: SaleSerializer
  end

  def create
    @sale = Sale.new(create_params)
    if @sale.save
      render status: :ok, json: @sale, serializer: SaleSerializer
    else
      render status: :unprocessable_entity, json: @sale.errors.messages
    end
  end

  private
  def create_params
    params.require(:sale).permit(
      :customer_id,
      :salesperson_id,
      :product_id,
      :city,
      :state,
      :price,
    )
  end
end
