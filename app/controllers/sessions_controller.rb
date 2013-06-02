class SessionsController < ApplicationController
	def new
	end

	
	def create
		logger.info "create"
		#render 'new'
		user = User.find_by_email(params[:email].downcase)
		if user && user.authenticate(params[:password])
			session[:user] = user.id
			sign_in user
			redirect_back_or user #9.20
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		logger.info "destroy"
		sign_out
		logger.debug "MGZ.20130202.1822 Sign out executed, #{signed_in?}"
		redirect_to root_url
	end
end
