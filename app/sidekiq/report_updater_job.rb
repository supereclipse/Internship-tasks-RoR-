class ReportUpdaterJob
  include Sidekiq::Job

  def perform(report_id)
    UpdateReportService.update(report_id)
  end
end
