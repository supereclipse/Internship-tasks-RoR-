# frozen_string_literal: true

require './bin/hw1/lib/vms_data_handler'
require './bin/hw1/lib/vm_cost'

# Составляет отчеты в виде массивов [id,значение]
class ReportHW
  def initialize(vm_list, volume_list, price)
    @vm_list = vm_list
    @volume_list = volume_list
    @price = price
  end

  def expensive(n)
    @vm_list.map { |vm| [vm.id, VMCost.cost_full(vm, @price)] }.sort_by { |_id, value| value }.last(n).reverse
  end

  def cheap(n)
    @vm_list.map { |vm| [vm.id, VMCost.cost_full(vm, @price)] }.sort_by { |_id, value| value }.first(n)
  end

  # Выводит n ВМ с наибольшим обьемом указанного параметра (cpu,ram,hdd_capacity)
  def most_capacity_of_type(n, type)
    # Подставляю аргумент type в название метода с помощью send
    @vm_list.map { |vm| [vm.id, vm.send(type.to_sym).to_i] }.sort_by { |_id, value| value }.last(n).reverse
  end

  # Выводит n ВМ с наибольшим количеством дисков опр. типа
  def e_volume_amount(n, type = 'All')
    # Проходит по массиву обьектов класса ExtraVolume и записывает id и кол-во в @e_vol_amount_list
    @volume_list.map do |extra|
      [extra.vm_id, extra.get_amount_of_type(type)]
    end.sort_by { |_id, value| value }.last(n).reverse
  end

  # Выводит n ВМ с наибольшим обьемом дисков опр. типа
  def e_volume_volume(n, type = 'All')
    @volume_list.map do |extra|
      [extra.vm_id, extra.get_volume_of_type(type)]
    end.sort_by { |_id, value| value }.last(n).reverse
  end
end
