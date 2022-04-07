class FieldsController < ApplicationController
  before_action :field_set, only: [:show]

  def index
    # 現在の俳句のステータスによって取得するfieldを選択
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
    # 投票画面ではランダム順で俳句を表示
    if @field.status == 'voting'
      @haikus = @field.haikus.shuffle
    # 結果画面では得票数順で俳句を表示
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

  def past
    @fields = Field.where(status: 'finished').order(updated_at: :desc)
  end

  private

  def field_set
    @field = Field.find(params[:id])
  end
end
