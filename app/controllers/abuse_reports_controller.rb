class AbuseReportsController < ApplicationController
  def create
    @ad = Ad.find(params[:abuse_report][:ad_id])
    @abuse_report = AbuseReport.new(params[:abuse_report])
    if @abuse_report.name.present? && @abuse_report.email.present? && @abuse_report.message.present?
      @abuse_report.save
      flash[:notice] = "Abuse report has been sended"
    else
      flash[:error] = "Please fill out fields correctly"
    end

    redirect_to ad_path(:state => @ad.state, :city => @ad.city, :category => @ad.category, :id => @ad.id)
  end
end
