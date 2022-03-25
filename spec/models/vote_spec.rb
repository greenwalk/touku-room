require 'rails_helper'

RSpec.describe Vote, type: :model do
  before do
    @vote = FactoryBot.build(:vote)
  end

  describe '投票機能' do
    context '投句できる場合' do
      it '全ての情報が存在すれば投票できる' do
        expect(@vote).to be_valid
      end
    end
    context '投票できない場合' do
      it 'userがひもづいていないと設置できない' do
        @vote.user = nil
        @vote.valid?
        expect(@vote.errors.full_messages).to include("Userを入力してください")
      end
      it 'Haikuがひもづいていないと設置できない' do
        @vote.haiku = nil
        @vote.valid?
        expect(@vote.errors.full_messages).to include("Haikuを入力してください")
      end
    end
  end
end
