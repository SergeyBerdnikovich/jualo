class ApplicationController < ActionController::Base
	protect_from_forgery

	def generate_captcha(string)
		 `figlet -f banner #{string}`.to_s.gsub(/\n/,"<br>").gsub(/#/,"*").gsub(/ /,"<font color='white'>*</font>")
	end
 
	def after_sign_in_path_for(resource_or_scope)
		if session[:attach_token]
			token = AttachToken.where('token = ?', session[:attach_token]).first
			if token
				ad = token.ad
				token.ad.user = current_user
				token.ad.save
				token.delete
				return ad_path(ad.state,ad.city,ad.category,ad)
			end
		end
		if session['redirect_path']
			return session['redirect_path']
		else
			return root_path
		end
	end


end
