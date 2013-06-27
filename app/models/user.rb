class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me,:provider, :uid,:name, :phone, :blackberry_pin
	has_many :ads

	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		unless user

			user_exist = User.where('email = ?', auth.info.email).first #check if user exists
			if user_exist
				user_exist.update_attributes(:provider => auth.provider, :uid => auth.uid)
				user_exist.save
				return user_exist

			else
				user = User.create(name:auth.extra.raw_info.name,
				provider:auth.provider,
				uid:auth.uid,
				email:auth.info.email,
				password:Devise.friendly_token[0,20]
				)
			end


		end
		user
	end


end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		# You need to implement the method below in your model (e.g. app/models/user.rb)
		@user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end
end