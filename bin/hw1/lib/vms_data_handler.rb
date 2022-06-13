# frozen_string_literal: true

require './bin/hw1/lib/parser'
require './bin/hw1/lib/vm'

# Обрабатывает данные по vm
class VMSDataHandler
  # Создает массив обьектов класса vm для каждой машины по которой есть данные
  def self.create_vm_list
    vm_list = []
    vms_parser = Parser.new('./bin/hw1/data/csv_data/vms.csv', %i[Id Cpu Ram Hdd_type Hdd_capacity])
    vms_parser.pull_hash.map do |row|
      vm_list.append(VM.new(row[:Id], row[:Cpu], row[:Ram], row[:Hdd_type], row[:Hdd_capacity]))
    end
    vm_list
  end
end
