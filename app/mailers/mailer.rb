class Mailer < ActionMailer::Base
  default :from => "contact@jualo.com"

  def send_message_to_friend(params)
    @nama = params[:nama]
    @email_a_friend = params[:email_a_friend]
    @your_email = params[:your_email]
    @pesan = params[:pesan]
    mail(:to => @email_a_friend, :subject => "From your friend - #{@your_email}")
  end

  def send_message_to_ad_user(params, ad_user_email)
    @nama = params[:nama]
    @email = params[:email]
    @phone_number = params[:phone_number]
    @subyek = params[:subyek]
    @pesan = params[:pesan]
    mail(:to => ad_user_email, :subject => @subyek)
  end
end