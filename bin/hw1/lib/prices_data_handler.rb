# frozen_string_literal: true

require './bin/hw1/lib/parser'
require './bin/hw1/lib/pricelist'

# Обрабатывает данные по price
class PricesDataHandler
  def self.create_price_list
    prices_parser = Parser.new('./bin/hw1/data/csv_data/prices.csv', %i[Type Price])
    PriceList.new(prices_parser.pull_hash.map)
  end
end
