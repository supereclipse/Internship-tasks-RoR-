# frozen_string_literal: true

# ExtraVolume class
class ExtraVolume
  attr_reader :vm_id, :list_of_volumes

  def initialize(vm_id, list_of_volumes)
    @vm_id = vm_id
    @list_of_volumes = list_of_volumes
  end

  # Считает кол-во дисков опр типа
  def get_amount_of_type(type)
    amount = 0
    @list_of_volumes.map { |row| amount += 1 if type == 'All' || type == row[:Hdd_type] }
    amount
  end

  # Считает обьем дисков опр типа
  def get_volume_of_type(type)
    volume = 0
    @list_of_volumes.map { |row| volume += row[:Hdd_capacity].to_i if type == 'All' || type == row[:Hdd_type] }
    volume
  end
end
