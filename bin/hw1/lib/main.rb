# frozen_string_literal: true

require './bin/hw1/lib/report'
require './bin/hw1/lib/report_presenter'

class Main
  def initialize
    @vm_list = VMSDataHandler.create_vm_list
    @volume_list = VolumesDataHandler.create_volume_list
    @price = PricesDataHandler.create_price_list
  end

  def report
    ReportHW.new(@vm_list, @volume_list, @price)
  end
end

# puts 'Самые дорогие'
# ReportPresenter.present(report.expensive(3))
# puts 'Самые дешевые'
# ReportPresenter.present(report.cheap(3))
# puts 'Самые обьемные'
# ReportPresenter.present(report.most_capacity_of_type(3, 'cpu'))
# puts 'Самое большое кол-во доп. дисков'
# ReportPresenter.present(report.e_volume_amount(3, 'ssd'))
# puts 'Самый большой обьем доп. дисков'
# ReportPresenter.present(report.e_volume_volume(3, 'sata'))
