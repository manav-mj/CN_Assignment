class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def welcome
    redirect_to root_path if logged_in?
  end

  def destroy
    session[:user_id] = -1
    redirect_to welcome_path
  end
end
