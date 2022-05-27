# frozen_string_literal: true

require './hw1/lib/report'
require './hw1/lib/report_presenter'
require 'csv'
require './hw1/lib/data_handler'

depth = ENV['depth'].to_i

# Reading data from csv files and converting it to hash
volumes_data = CSV.read(ENV['volumes_path']).map { |arr| Hash[[%i[Vm_id Hdd_type Hdd_capacity], arr].transpose] }
vms_data = CSV.read(ENV['vms_path']).map { |arr| Hash[[%i[Id Cpu Ram Hdd_type Hdd_capacity], arr].transpose] }
prices = Hash[CSV.read(ENV['prices_path'])]

# Creating a list of vms instances
vm_list = DataHandler.new(vms_data, volumes_data).create_vm_list

report = Report.new(vm_list, prices)

ReportPresenter.present(report.expensive(depth))
ReportPresenter.present(report.cheap(depth))
ReportPresenter.present(report.most_capacity_of_type(depth, 'cpu'))
ReportPresenter.present(report.e_volume_amount(depth, 'ssd'))
ReportPresenter.present(report.e_volume_volume(depth, 'sata'))
