module SessionsHelper

	#Logs in the current user
	def log_in(user)
		session[:user_id] = user.id			
	end

	#Remembers a user in a persistent session
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token	
	end	

	#Returns the current logged-in user
	def current_user
		if session[:user_id]
			#create an instance variable so we only hit the database once
			@current_user ||= User.find_by(id: session[:user_id])	
		elsif cookies.signed[:user_id]
			#when user closes the browser
	
			user = User.find_by(id: cookies.signed[:user_id])
			if user && user.authenticate?(cookies[:remember_token])
				log_in user
				@current_user = user
			end

		end
	end

	#Returns true if the user is logged in 
	def logged_in?
		!current_user.nil?
	end

	#Forgets a persistent user
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)	
	end

	#Logs out the current user
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

end
