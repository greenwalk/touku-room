class FieldsController < ApplicationController
  def index
    if Field.exists?(status: "touku")
      fields = Field.where(status: "touku")
      @field = fields.order(updated_at: :desc)[0]
    elsif Field.exist?(status: "voting")
      fields = Field.where(status: "voting")
      @field = fields.order(updated_at: :desc)[0]
    end
    @fields = Field.where(status: "finished").order(updated_at: :desc)
  end

  def show
  end
end
