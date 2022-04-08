class ThemesController < ApplicationController
  before_action :theme_set, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_top, only: [:edit]

  def new
    # 使われていないお題がある場合は、それを表示。ない場合は、投稿画面へ。
    themes = current_user.themes.where(status: 'set')
    @theme = if themes.exists?
               themes.order(updated_at: :desc)[-1]
             else
               Theme.new
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
    redirect_to root_path unless current_user.id == @theme.user_id
  end
end
