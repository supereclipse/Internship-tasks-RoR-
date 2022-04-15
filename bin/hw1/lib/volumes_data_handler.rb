# frozen_string_literal: true

require './bin/hw1/lib/parser'
require './bin/hw1/lib/extra_volume'

# Обрабатывает данные по доп. дискам
class VolumesDataHandler
  # Возвращает список всех доп. жестких дисков для конкретного id ВM
  def self.get_all_volume_by_vm_id(vm_id)
    list = []
    volumes_parser = Parser.new('./bin/hw1/data/csv_data/volumes.csv', %i[Vm_id Hdd_type Hdd_capacity])
    volumes_parser.pull_hash.map { |row| list.append(row) if row[:Vm_id] == vm_id }
    list
  end

  # Создает массив обьектов класса ExtraVolume для каждого уникального id ВМ и соотв-го ему списка доп. жестких дисков
  def self.create_volume_list
    volume_list = []
    temp1 = []
    volumes_parser = Parser.new('./bin/hw1/data/csv_data/volumes.csv', %i[Vm_id Hdd_type Hdd_capacity])

    # Добавляю в список temp1 все id ВМ из спаршенного списка
    volumes_parser.pull_hash.map { |x| temp1.append(x[:Vm_id]) }

    # Для каждого уникального id ВМ создаю обьекст класса ExtraVolume
    temp1.uniq.each { |id| volume_list.append(ExtraVolume.new(id, get_all_volume_by_vm_id(id))) }
    volume_list
  end
end
