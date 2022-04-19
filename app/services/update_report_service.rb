require './bin/hw1/lib/main'
require 'json'

# HW 8 part 1
class UpdateReportService
  def self.update(report_id)
    # Getting report instance from HW1
    report_hw = Main.new.report

    report = Report.find_by_id(report_id)

    # Updating "result" field with required report from hw1
    report.update(result: JSON.generate(report_hw.send(report.reptype, report.depth)))
  end
end
