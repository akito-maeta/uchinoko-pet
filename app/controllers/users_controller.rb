class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user
  before_action :correct_user, only: [:update, :edit]

  def show
    @posts = @user.posts
  end

  def edit
    if @user.email == 'guest@guest.work'
      flash[:guest] = 'ゲストユーザーは編集できません'
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :pet_name, :image, :email, :introduction, :address, :latitude, :longitude)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
