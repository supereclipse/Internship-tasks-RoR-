require './bin/hw1/lib/main'

# HW 8 part 1
class UpdateReportService

  def self.update(depth)
    depth = depth.to_i

    # Getting report from HW1
    report_hw = Main.new.report

    # Clearing values from previous report
    Report.all.destroy_all

    # Inserting values from new report
    report_hw.expensive(depth.to_i).each { |x| Report.create(vmname: x[0], result: x[1], reptype: 'expensive') }
    report_hw.cheap(depth.to_i).each { |x| Report.create(vmname: x[0], result: x[1], reptype: 'cheap') }
    report_hw.most_capacity_of_type(depth.to_i, 'cpu').each { |x| Report.create(vmname: x[0], result: x[1], reptype: 'most_cap') }
    report_hw.e_volume_amount(depth.to_i).each { |x| Report.create(vmname: x[0], result: x[1], reptype: 'vol_am') }
    report_hw.e_volume_volume(depth.to_i).each { |x| Report.create(vmname: x[0], result: x[1], reptype: 'vol_vol') }
  end
end
