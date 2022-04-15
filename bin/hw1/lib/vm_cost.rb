# frozen_string_literal: true

require './bin/hw1/lib/vm'
require './bin/hw1/lib/prices_data_handler'
require './bin/hw1/lib/volumes_data_handler'

# Класс для подсчета стоимости vm и доп.дисков
class VMCost
  def self.cost_full(vm, price)
    cost_without_extra_volume(vm, price) + cost_of_extra_volume(vm, price)
  end

  def self.cost_without_extra_volume(vm, price)
    cpu_price = price.get_price_by_type('cpu') * vm.cpu.to_i
    ram_price = price.get_price_by_type('ram') * vm.ram.to_i
    mem_price = price.get_price_by_type(vm.hdd_type) * vm.hdd_capacity.to_i

    cpu_price + ram_price + mem_price
  end

  def self.cost_of_extra_volume(vm, price)
    cost = 0
    VolumesDataHandler.get_all_volume_by_vm_id(vm.id).map do |row|
      cost += price.get_price_by_type(row[:Hdd_type]) * row[:Hdd_capacity].to_i
    end
    cost
  end
end
