class ReportUpdaterJob
  include Sidekiq::Job

  def perform(depth)
    UpdateReportService.update(depth)
  end
end
