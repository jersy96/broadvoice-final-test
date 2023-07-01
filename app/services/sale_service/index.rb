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
    @sales = Sale.all.includes(:salesperson, :customer, :product)
    if @search_term.present?
      @sales = @sales.joins(
        'INNER JOIN users AS salespeople ON salespeople.id = sales.salesperson_id',
        'INNER JOIN users AS customers ON customers.id = sales.customer_id',
        :product
      )
      if @start_date.present? || @end_date.present?
        @sales = @sales.where(
          %{
            #{search_term_conditions}
            OR #{date_conditions}
          }, {
            search_term: "%#{ Sale.sanitize_sql_like(@search_term) }%",
            start_date: @start_date,
            end_date: @end_date,
          }
        )
      else
        @sales = @sales.where(
          search_term_conditions,
          { search_term: "%#{ Sale.sanitize_sql_like(@search_term) }%" }
        )
      end
    elsif @start_date.present? || @end_date.present?
      @sales = @sales.where(
        date_conditions,
        { start_date: @start_date, end_date: @end_date }
      )
    end
    return @sales.limit(@per_page).offset(@offset).order('sales.created_at')
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

  def search_term_conditions
    %{
      LOWER(salespeople.name) LIKE :search_term
      OR LOWER(customers.email) LIKE :search_term
      OR LOWER(products.code) LIKE :search_term
      OR LOWER(sales.city) LIKE :search_term
      OR LOWER(sales.state) LIKE :search_term
    }
  end

  def date_conditions
    if @start_date.present? && @end_date.present?
      "sales.created_at BETWEEN :start_date AND :end_date"
    elsif @start_date.present?
      "sales.created_at >= :start_date"
    elsif @end_date.present?
      "sales.created_at <= :end_date"
    end
  end
end