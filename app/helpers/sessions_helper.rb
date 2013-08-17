module SessionsHelper

	def sign_in(user)
		logger.info "sign_in"
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

  # Checks if an user is signed as an administrator
	def signed_in_as_admin?
		signed_in? && current_user.admin?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	#9.16
	def current_user?(user)
		user == current_user
	end

	#10.27
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_path, notice: "Please sign in."
		end
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	#9.18
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	#9.18
	def store_location
		session[:return_to] = request.url
	end
end