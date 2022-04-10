# frozen_string_literal: true

# Class Price
class Price
  def initialize(prices)
    @prices = prices
  end

  def get_price_by_type(type)
    @prices.map { |row| return row[:Price].to_i if row[:Type] == type }
  end
end
