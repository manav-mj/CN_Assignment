class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
    redirect_to root_path if logged_in?
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :password, :role))
    session[:user_id] = @user.id
    redirect_to root_path
  end
end
