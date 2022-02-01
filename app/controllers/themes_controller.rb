class ThemesController < ApplicationController
  before_action :theme_set, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_top, only: [:edit]

  def new
    if Theme.exists?(status: 0)
      themes = current_user.themes
      @theme = themes[-1]
    else
      @theme = Theme.new
    end
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @theme.update(theme_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:season_id, :status, :image).merge(user_id: current_user.id)
  end

  def theme_set
    @theme = Theme.find(params[:id])
  end

  def move_to_top
    unless current_user.id == @theme.user_id
      redirect_to root_path
    end
  end

end
