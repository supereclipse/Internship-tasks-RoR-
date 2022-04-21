# HW 8 part 1
class ReportsController < ApplicationController
  # Temp line for testing with curl
  skip_before_action :verify_authenticity_token

  # curl -d '{"reptype":"expensive", "depth":10}' -H "Content-Type: application/json" -X POST http://localhost:3000/reports
  # Creates a new report record with required "depth" and "reptype"
  def create
    report = Report.create(report_params)

    # Starts an async task of updating "result" field with report data from hw1
    ReportUpdaterJob.perform_async(report.id)

    render json: { result: 'true' }
  rescue ArgumentError => e
    render json: { result: 'false', error: e.message }
  end

  def index
    reports = Report.all
    render json: reports
  end

  private
  
  def report_params
    params.require(:report).permit(:reptype, :depth)
  end
end
