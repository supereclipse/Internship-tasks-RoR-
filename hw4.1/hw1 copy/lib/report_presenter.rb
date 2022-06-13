# Класс вывода отчетов
class ReportPresenter
  def self.present(report)
    puts report[1]
    report[0].each { |line| puts "VM_ID: #{line[0]} Result: #{line[1]}" }
  end
end
