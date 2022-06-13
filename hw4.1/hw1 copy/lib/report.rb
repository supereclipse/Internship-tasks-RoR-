# Составляет отчеты в виде массивов [id,значение]
class Report
  def initialize(vm_list, prices)
    @vm_list = vm_list
    @prices = prices
  end

  def expensive(n)
    [sort_by_value(@vm_list.map { |vm| [vm.id, vm.cost_full(@prices)] }, n), 'Expensive']
  end

  def cheap(n)
    [@vm_list.map { |vm| [vm.id, vm.cost_full(@prices)] }.sort_by { |_id, value| value }.first(n), 'Cheap']
  end

  # Выводит n ВМ с наибольшим обьемом указанного параметра (cpu,ram,hdd_capacity)
  def most_capacity_of_type(n, type)
    [sort_by_value(@vm_list.map { |vm| [vm.id, vm.send(type.to_sym).to_i] }, n), 'Most capacity']
  end

  # Выводит n ВМ с наибольшим количеством дисков опр. типа
  def e_volume_amount(n, type = 'All')
    [sort_by_value(@vm_list.map { |vm| [vm.id, vm.get_vol_amount_of_type(type)] }, n), 'Extra volume amount']
  end

  # Выводит n ВМ с наибольшим обьемом дисков опр. типа
  def e_volume_volume(n, type = 'All')
    [sort_by_value(@vm_list.map { |vm| [vm.id, vm.get_vol_volume_of_type(type)] }, n), 'Extra volume volume']
  end

  private

  def sort_by_value(list, n)
    list.sort_by { |_id, value| value }.last(n).reverse
  end
end
