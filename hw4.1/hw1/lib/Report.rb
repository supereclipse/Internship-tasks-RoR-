# frozen_string_literal: true

require './lib/vms_data_handler'
require './lib/vm_cost'

# Составляет отчеты в виде массивов [id,значение]
class Report
  def self.expensive(vm_list, price, n)
    vm_list.map { |vm| [vm.id, VMCost.cost_full(vm, price)] }.sort_by { |_id, value| value }.last(n).reverse
  end

  def self.cheap(vm_list, price, n)
    vm_list.map { |vm| [vm.id, VMCost.cost_full(vm, price)] }.sort_by { |_id, value| value }.first(n)
  end

  # Выводит n ВМ с наибольшим обьемом указанного параметра (cpu,ram,hdd_capacity)
  def self.most_capacity_of_type(vm_list, n, type)
    # Подставляю аргумент type в название метода с помощью send
    vm_list.map { |vm| [vm.id, vm.send(type.to_sym).to_i] }.sort_by { |_id, value| value }.last(n).reverse
  end

  # Выводит n ВМ с наибольшим количеством дисков опр. типа
  def self.e_volume_amount(volume_list, n, type = 'All')
    # Проходит по массиву обьектов класса ExtraVolume и записывает id и кол-во в @e_vol_amount_list
    volume_list.map do |extra|
      [extra.vm_id, extra.get_amount_of_type(type)]
    end.sort_by { |_id, value| value }.last(n).reverse
  end

  # Выводит n ВМ с наибольшим обьемом дисков опр. типа
  def self.e_volume_volume(volume_list, n, type = 'All')
    volume_list.map do |extra|
      [extra.vm_id, extra.get_volume_of_type(type)]
    end.sort_by { |_id, value| value }.last(n).reverse
  end
end
