# HW 8 part 1
class ReportsController < ApplicationController
  # Temp line for testing with curl
  skip_before_action :verify_authenticity_token

  # curl -d '{"reptype":"expensive", "depth":10}' -H "Content-Type: application/json" -X POST http://localhost:3000/reports
  # Creates a new report record with required "depth" and "reptype"
  def create
    report = Report.new(report_params)

    if report.save
      render plain: 'Report sucessfully created and queued for updating with latest data'

      # Starts an async task of updating "result" field with report data from hw1
      ReportUpdaterJob.perform_async(report.id)
    else
      render plain: 'Failed to create new report'
    end
  end

  def index
    reports = Report.all
    render json: reports
  end

  def report_params
    params.require(:report).permit(:reptype, :depth)
  end
end
