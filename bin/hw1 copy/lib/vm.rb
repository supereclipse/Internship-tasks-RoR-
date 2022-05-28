# VM class
class VM
  attr_reader :id, :cpu, :ram, :hdd_type, :hdd_capacity, :volume

  def initialize(id, cpu, ram, hdd_type, hdd_capacity, volume)
    @id = id
    @cpu = cpu
    @ram = ram
    @hdd_type = hdd_type
    @hdd_capacity = hdd_capacity
    @volume = volume
  end

  def cost_full(prices)
    cost_without_extra_volume(prices) + cost_of_extra_volume(prices)
  end

  def cost_without_extra_volume(prices)
    cpu_price = prices['cpu'].to_i * @cpu.to_i
    ram_price = prices['ram'].to_i * @ram.to_i
    mem_price = prices[@hdd_type].to_i * @hdd_capacity.to_i

    cpu_price + ram_price + mem_price
  end

  def cost_of_extra_volume(prices)
    @volume ? @volume.sum { |row| prices[row[:Hdd_type]].to_i * row[:Hdd_capacity].to_i } : 0
  end

  # Считает кол-во дисков опр типа
  def get_vol_amount_of_type(type)
    @volume.sum { |row| type == 'All' || type == row[:Hdd_type] ? 1 : 0 }
  end

  # Считает обьем дисков опр типа
  def get_vol_volume_of_type(type)
    @volume.sum { |row| type == 'All' || type == row[:Hdd_type] ? row[:Hdd_capacity].to_i : 0 }
  end
end
