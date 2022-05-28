# frozen_string_literal: true

require 'csv'
require './bin/hw1 copy/lib/report'
require './bin/hw1 copy/lib/report_presenter'
require './bin/hw1 copy/lib/data_handler'

class Main
  VOLUMES_PATH = './bin/hw1 copy/data/csv_data/volumes.csv'
  VMS_PATH = './bin/hw1 copy/data/csv_data/vms.csv'
  PRICES_PATH = './bin/hw1 copy/data/csv_data/prices.csv'

  def report
    # Reading data from csv files and converting it to hash

    volumes_data = CSV.read(VOLUMES_PATH).map { |arr| Hash[[%i[Vm_id Hdd_type Hdd_capacity], arr].transpose] }
    vms_data = CSV.read(VMS_PATH).map { |arr| Hash[[%i[Id Cpu Ram Hdd_type Hdd_capacity], arr].transpose] }
    prices = Hash[CSV.read(PRICES_PATH)]

    # Creating a list of vms instances
    vm_list = DataHandler.new(vms_data, volumes_data).create_vm_list

    Report.new(vm_list, prices)
  end
end
