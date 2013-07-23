class SessionsController < ApplicationController
	def new	
	end

 	def create
	  	user = User.find_by_email(params[:email])
  		if user && user.authenticate(params[:password])
	  		if params[:remember_me]
	  			cookies.permanent[:auth_token] = user.auth_token
	  		else
	  			cookies[:auth_token] = user.auth_token
	  		end
	  		redirect_to tasks_path, notice:  "Signed in"
	  	else
	  		flash.now[:notice] = "Error signing in"
	  		render 'new'
	  	end
	end

	def destroy
		cookies.delete(:auth_token)
		flash[:notice] = "Signed out"
		redirect_to tasks_path
	end

  private

  	def session_params
  		params.require(:session).permit(:email, :password)  		
  	end
end
