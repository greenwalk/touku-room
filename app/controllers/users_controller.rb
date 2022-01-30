class UsersController < ApplicationController
  before_action :move_to_index, only: [:edit, :update]

  def edit
  end
  
  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
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
