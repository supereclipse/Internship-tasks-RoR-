# frozen_string_literal: true

require './lib/Report'
require './lib/Report_presenter'

vm_list = VMSDataHandler.create_vm_list
volumes_list = VolumesDataHandler.create_volume_list
price = PricesDataHandler.create_price_list

puts 'Самые дорогие'
ReportPresenter.present(Report.expensive(vm_list, price, 3))
puts 'Самые дешевые'
ReportPresenter.present(Report.cheap(vm_list, price, 3))
puts 'Самые обьемные'
ReportPresenter.present(Report.most_capacity_of_type(vm_list, 3, 'cpu'))
puts 'Самое большое кол-во доп. дисков'
ReportPresenter.present(Report.e_volume_amount(volumes_list, 3, 'ssd'))
puts 'Самый большой обьем доп. дисков'
ReportPresenter.present(Report.e_volume_volume(volumes_list, 3, 'sata'))
