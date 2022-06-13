# frozen_string_literal: true

require './hw1/lib/vm'

# Обрабатывает данные по vm
class DataHandler
  def initialize(vms_data, volumes_data)
    @vms_data = vms_data
    @volumes_data = volumes_data
  end

  # Создает массив обьектов класса vm для каждой машины по которой есть данные
  def create_vm_list
    @vms_data.map { |row| VM.new(*row.values, volume_by_vm_id(row[:Id])) }
  end

  # Возвращает список всех доп. жестких дисков для конкретного id ВM
  def volume_by_vm_id(vm_id)
    @volumes_data.group_by { |row| row[:Vm_id] }[vm_id].to_a
  end
end
