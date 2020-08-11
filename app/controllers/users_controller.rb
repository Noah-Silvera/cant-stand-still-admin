class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    @user = User.find params[:id]
    render json: @user
  end

  def create
    User.create(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
