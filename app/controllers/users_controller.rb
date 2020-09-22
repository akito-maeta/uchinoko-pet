class UsersController < ApplicationController

def show
    @user = User.find_by(name: params[:name])
    @posts = @user.posts
  end

  def edit
    @user = User.find_by(name: params[:name])
  end

  def update
    @user = User.find_by(name: params[:name])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private
  def owner_params
    params.require(:user).permit(:name, :pet_name, :image, :email)
  end
end
