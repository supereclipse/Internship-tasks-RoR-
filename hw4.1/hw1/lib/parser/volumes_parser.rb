# frozen_string_literal: true

require './lib/parser'

# Парсит значения по доп. дискам
class VolumesParser < Parser
  def initialize
    super
    @dir = './data/csv_data/volumes.csv'
    @keys = %i[Vm_id Hdd_type Hdd_capacity]
  end
end
