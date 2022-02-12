class FieldsController < ApplicationController
  before_action :field_set, only: [:show]

  def index
    if Field.exists?(status: "touku")
      fields = Field.where(status: "touku")
    elsif Field.exist?(status: "voting")
      fields = Field.where(status: "voting")
    end
    @field = fields.order(updated_at: :desc)[0]
    @fields = Field.where(status: "finished").order(updated_at: :desc)
  end

  def show
    @haikus = @field.haikus.shuffle
  end

  private
  def field_set
    @field = Field.find(params[:id])
  end
end
