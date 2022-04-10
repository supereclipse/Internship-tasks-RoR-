# frozen_string_literal: true

require './lib/vm'
require './lib/prices_data_handler'
require './lib/volumes_data_handler'

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

  # Метод может считать цену доп. дисков как для переданной vm так и для переданного массива с доп.дисками (if vm == nil)
  def self.cost_of_extra_volume(vm, price, opt_volume_list = nil)
    cost = 0
    if vm.nil?
      (0...opt_volume_list.length).step(2).each do |i|
        cost += price.get_price_by_type(opt_volume_list[i]) * opt_volume_list[i + 1].to_i
      end
    else
      VolumesDataHandler.get_all_volume_by_vm_id(vm.id).map do |row|
        cost += price.get_price_by_type(row[:Hdd_type]) * row[:Hdd_capacity].to_i
      end
    end
    cost
  end
end
