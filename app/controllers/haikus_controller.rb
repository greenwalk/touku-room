class HaikusController < ApplicationController
  before_action :haiku_set, only: [:edit, :update, :destroy, :show]
  before_action :field_set, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_top, only: [:edit]
  before_action :move_to_theme, only: [:new]
  before_action :now_field, only: [:new, :create, :edit, :update, :destroy]
  before_action :finished_field, only: [:show]

  def new
    # 俳句を既に投稿している場合は、俳句編集ページへ移動。していない場合は、投句ページへ移動
    if Haiku.exists?(user_id: current_user.id, field_id: @field.id)
      @haiku = @field.haikus.where(user_id: current_user.id)[0]
      redirect_to "/fields/#{@haiku.field.id}/haikus/#{@haiku.id}/edit"
    else
      @haiku = Haiku.new
    end
  end

  def create
    @haiku = Haiku.new(haiku_params)
    if @haiku.save
      redirect_to "/fields/#{@haiku.field.id}/haikus/#{@haiku.id}/edit"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @haiku.update(haiku_params)
      redirect_to "/fields/#{@haiku.field.id}/haikus/#{@haiku.id}/edit"
    else
      render :edit
    end
  end

  def destroy
    @haiku.destroy
    redirect_to root_path
  end
  
  def show
    @votes = @haiku.votes
  end

  private

  def haiku_params
    params.require(:haiku).permit(:content).merge(user_id: current_user.id, field_id: params[:field_id])
  end

  def haiku_set
    @haiku = Haiku.find(params[:id])
  end

  def field_set
    @field = Field.find(params[:field_id])
  end

  def move_to_top
    redirect_to root_path unless current_user.id == @haiku.user_id
  end

  def move_to_theme
    redirect_to new_theme_path unless Theme.exists?(user_id: current_user.id, status: 'set')
  end

  def now_field
    redirect_to root_path unless @field.status == 'touku'
  end

  def finished_field
    redirect_to root_path unless @field.status == 'finished'
  end
end
