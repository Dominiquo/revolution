class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : user.forget
    	redirect_to user
    else
    	flash[:danger] = 'Are you a with the government?'
    	render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end

end
