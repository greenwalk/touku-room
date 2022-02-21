class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :move_to_index, only: [:edit]

  def edit
  end
  
  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @haikus = Haiku.includes(field: :theme).where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile)
  end

  def move_to_index
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.id == @user.id
  end
end
