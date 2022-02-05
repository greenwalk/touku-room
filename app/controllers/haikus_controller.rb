class HaikusController < ApplicationController
  before_action :haiku_set, only: [:update]
  before_action :authenticate_user!, only: [:new]
  before_action :move_to_top, only: [:edit]

  def new
    @field = Field.find(params[:field_id])
    @haiku = Haiku.new
  end

  def create
    @haiku = Haiku.new(haiku_params)
    if @haiku.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @haiku.update(haiku_params)
      redirect_to edit_haiku_path
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

  def move_to_top
    unless current_user.id == @haiku.user_id
      redirect_to root_path
    end
  end

end
