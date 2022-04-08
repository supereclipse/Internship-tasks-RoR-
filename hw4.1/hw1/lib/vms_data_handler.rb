# frozen_string_literal: true

require './lib/parser/vms_parser'
require './lib/vm'

# Обрабатывает данные по vm
class VMSDataHandler
  # Создает массив обьектов класса vm для каждой машины по которой есть данные
  def self.create_vm_list
    vm_list = []
    vms_parser = VMSParser.new
    vms_parser.pull_arr.map { |row| vm_list.append(VM.new(*row)) }
    vm_list
  end
end
