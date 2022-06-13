# frozen_string_literal: true

require './lib/parser'

# Парсит значения по vm
class VMSParser < Parser
  def initialize
    super
    @dir = './data/csv_data/vms.csv'
    @keys = %i[Id Cpu Ram Hdd_type Hdd_capacity]
  end
end
