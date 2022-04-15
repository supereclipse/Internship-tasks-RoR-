# HW 8 part 1
class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_depth, only: %i[update]

  # curl -XPUT --data "depth=3" http://localhost:3000/reports/1
  def update
    ReportUpdaterJob.perform_async(params[:depth])
  end

  def index
    reports = Report.all

    reports_list = {
      expensive: reports.select(:vmname, :result).where(reptype: 'expensive'),
      cheap: reports.select(:vmname, :result).where(reptype: 'cheap'),
      most_cap: reports.select(:vmname, :result).where(reptype: 'most_cap'),
      vol_am: reports.select(:vmname, :result).where(reptype: 'vol_am'),
      vol_vol: reports.select(:vmname, :result).where(reptype: 'vol_vol')
    }
    render json: reports_list
  end

  def require_depth
    params.require(:depth)
  end
end
