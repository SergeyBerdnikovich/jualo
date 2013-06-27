class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    if session[:user]
      params[:user].merge!(session[:user])
      session[:user] = nil
    end
    super
  end

  def update
    super
  end
end 