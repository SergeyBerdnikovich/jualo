class SpamReportsController < ApplicationController
  def create
    @ad = Ad.find(params[:spam_report][:ad_id])
    @spam_report = SpamReport.new(params[:spam_report])
    if @spam_report.name.present? && @spam_report.email.present? && @spam_report.message.present?
      @spam_report.save
      flash[:notice] = "Spam report has been sended"
    else
      flash[:error] = "Please fill out fields correctly"
    end

    redirect_to ad_path(:state => @ad.state, :city => @ad.city, :category => @ad.category, :id => @ad.id)
  end
end
