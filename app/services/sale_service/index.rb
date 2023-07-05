class SaleService::Index
  def initialize(
    page: 1, per_page: 10,
    search_term: nil, start_date: nil, end_date: nil
  )
    @page = page.to_i
    @per_page = per_page.to_i
    @offset = (@page - 1) * @per_page
    @search_term = search_term&.downcase
    parse_dates(start_date, end_date)
  end

  def call
    @sales = Sale.all
    apply_filters if can_apply_filters
    apply_pagination
    return @sales.includes(:salesperson, :customer, :product).order('sales.created_at')
  end

  private
  def parse_dates(start_date, end_date)
    begin
      @start_date = DateTime.parse(start_date) if start_date.present?
      @end_date = DateTime.parse(end_date) if end_date.present?
      if start_date.present? && end_date.present? && @end_date < @start_date
        temp = @end_date
        @end_date = @start_date
        @start_date = temp
      end
    rescue
      @start_date = nil
      @end_date = nil
    end
  end

  def can_apply_filters
    @search_term.present? || @start_date.present? || @end_date.present?
  end

  def apply_filters
    @sales = @sales.ransack(build_ransack_query).result
  end

  def build_ransack_query
    conditions = []
    if @search_term.present?
      conditions = [
        { salesperson_name_cont: @search_term },
        { customer_email_cont: @search_term },
        { product_code_cont: @search_term },
        { city_cont: @search_term },
        { state_cont: @search_term },
      ]
    end

    conditions << date_conditions if date_conditions.present?

    { groupings: conditions, m: 'or' }
  end

  def apply_pagination
    @sales = @sales.limit(@per_page).offset(@offset)
  end

  def date_conditions
    @date_conditions ||= if @start_date.present? && @end_date.present?
      { created_at_gteq: @start_date, created_at_lteq: @end_date }
    elsif @start_date.present?
      { created_at_gteq: @start_date }
    elsif @end_date.present?
      { created_at_lteq: @end_date }
    end
    @date_conditions
  end
end