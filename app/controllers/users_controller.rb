class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :move_to_index, only: [:edit]

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @finished_haikus = Haiku.includes(user: :votes).where(user_id: @user.id).joins(:field).merge(Field.where(status: :finished)).order(updated_at: :desc)
    votes_count(@finished_haikus)
    @votes_rate = format('%.3f', (@total_votes.to_f / @total_votes_num).floor(3))
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile)
  end

  def move_to_index
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.id == @user.id
  end

  # 俳句を投稿したfieldに投票した投票者の数をカウント
  def votes_count(haikus)
    @total_votes = 0
    @total_votes_num = 0
    # ユーザーが投稿したhaikuをひとつずつ抽出
    haikus.each do |haiku|
      votes_ary = []
      # 抽出されたhaikuが投稿されたfieldにある全俳句の全投票者を配列に格納
      haiku.field.haikus.each do |haiku2|
        votes_ary << haiku2.votes.pluck(:user_id)
      end
      # それぞれ格納した投票をひとつの配列とし、user_idの重複を消し、その配列のサイズをそのfieldでの投票者数とする
      votes_num = votes_ary.flatten.uniq.size
      @total_votes_num += votes_num
      # 抽出された俳句が獲得した票数を加算
      @total_votes += haiku.votes.size
    end
  end
end
