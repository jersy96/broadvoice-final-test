class SalesController < ApplicationController
  def index
    @sales = SaleService::Index.new(
      page: params[:page], per_page: params[:per_page],
      search_term: params[:search_term], start_date: params[:start_date],
      end_date: params[:end_date]
    ).call
    render status: :ok, json: @sales, each_serializer: SaleSerializer
  end
end
