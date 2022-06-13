# frozen_string_literal: true

require './lib/parser'

# Парсит значения по ценам
class PricesParser < Parser
  def initialize
    super
    @dir = './data/csv_data/prices.csv'
    @keys = %i[Type Price]
  end
end
