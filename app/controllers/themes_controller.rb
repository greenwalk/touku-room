class ThemesController < ApplicationController

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

  private

  def theme_params
    params.require(:theme).permit(:season_id, :status, :image).merge(user_id: current_user.id)
  end

end
