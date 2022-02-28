class VotesController < ApplicationController
  before_action :haiku_set, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @vote = current_user.votes.new(haiku_id: @haiku.id)
    @vote.save
    respond_to do |format|
      format.js { render 'votes/destroy.js.erb' }
    end
  end

  def destroy
    @vote = Vote.find_by(user_id: current_user.id, haiku_id: @haiku.id)
    @vote.destroy
    respond_to do |format|
      format.js { render 'votes/create.js.erb' }
    end
  end

  private

  def haiku_set
    @haiku = Haiku.find(params[:haiku_id])
  end
end
