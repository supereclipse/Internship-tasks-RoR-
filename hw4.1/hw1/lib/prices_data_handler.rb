# frozen_string_literal: true

require './lib/parser/prices_parser'
require './lib/price'

# Обрабатывает данные по price
class PricesDataHandler
  def self.create_price_list
    prices_parser = PricesParser.new
    Price.new(prices_parser.pull_hash.map)
  end
end
