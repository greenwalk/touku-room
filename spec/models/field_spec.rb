require 'rails_helper'

RSpec.describe Field, type: :model do
  before do
    @field = FactoryBot.build(:field)
  end
  describe 'フィールド設置機能' do
    context '設置できる場合' do
      it '全ての情報が存在すれば設置できる' do
        expect(@field).to be_valid
      end
    end
    context '設置できない場合' do
      it 'ステータスが空では設置できない' do
        @field.status = nil
        @field.valid?
        expect(@field.errors.full_messages).to include("Statusを入力してください")
      end
      it 'themeがひもづいていないと設置できない' do
        @field.theme = nil
        @field.valid?
        expect(@field.errors.full_messages).to include("Themeを入力してください")
      end
    end
  end
end
