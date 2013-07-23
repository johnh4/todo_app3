class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		#if params[:remember_me]
  		cookies.permanent[:auth_token] = @user.auth_token
  		#else
  		#	cookies[:auth_token] = @user.auth_token
  		#end
  		flash[:notice] = "Signup executed successfully"
	  	redirect_to users_path  	
  	else
  		flash[:notice] = "Signup failed"
  		render 'new'
  	end
  end

  def index
  	@users = User.all
  end

  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
