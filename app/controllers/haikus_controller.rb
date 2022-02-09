class HaikusController < ApplicationController
  before_action :haiku_set, only: [:edit, :update]
  before_action :field_set, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_top, only: [:edit]
  before_action :move_to_edit, only: [:new]

  def new
    unless Haiku.exists?(user_id: current_user.id, field_id: @field.id)
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

  private
  def haiku_params
    params.require(:haiku).permit(:content, :content_sub).merge(user_id: current_user.id, field_id: params[:field_id] )
  end

  def haiku_set
    @haiku = Haiku.find(params[:id])
  end

  def field_set
    @field = Field.find(params[:field_id])
  end

  def move_to_top
    unless current_user.id == @haiku.user_id
      redirect_to root_path
    end
  end

  def move_to_edit
    if Haiku.exists?(user_id: current_user.id, field_id: @field.id)
      redirect_to "/fields/#{@haiku.field.id}/haikus/#{@haiku.id}/edit"
    end
  end

end