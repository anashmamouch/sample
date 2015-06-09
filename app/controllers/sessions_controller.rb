class SessionsController < ApplicationController
  def new
  	#@session = Session.new
  end

  def create
  	user = User.find_by(email: params[:session][:email])

  	if user && user.authenticate(params[:session][:password])
  		#Login the user and redirect to the user show page
  		log_in user
      if params[:session][:remember_me] == '1'
        remember user
      else
        forget user
      end
  		redirect_to user
  		
  	else
  		#Create an error message returns back to the login page
  		flash.now[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	if logged_in?
      log_out 
    end
    redirect_to root_url
  end
end
