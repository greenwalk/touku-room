class FieldsController < ApplicationController
  before_action :field_set, only: [:show]

  def index
    if Field.exists?(status: 'touku')
      fields = Field.where(status: 'touku')
    elsif Field.exists?(status: 'voting')
      fields = Field.where(status: 'voting')
    end
    @field = fields.order(updated_at: :desc)[0]
    @fields = Field.where(status: 'finished').order(updated_at: :desc)
    @last_time_field = @fields[0]
  end

  def show
    if @field.status == 'voting'
      @haikus = @field.haikus.shuffle
    elsif @field.status == 'finished'
      @haikus = @field.haikus.sort { |a, b| b.votes.size <=> a.votes.size }
    else
      redirect_to root_path
    end
  end

  def rule
  end

  def privacy_policy
  end

  private

  def field_set
    @field = Field.find(params[:id])
  end
end
