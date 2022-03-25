require 'rails_helper'

RSpec.describe Haiku, type: :model do
  before do
    @haiku = FactoryBot.build(:haiku)
  end

  describe '投句機能' do
    context '投句できる場合' do
      it '全ての情報が存在すれば設置できる' do
        expect(@haiku).to be_valid
      end
    end
    context '投句できない場合' do
      it 'contentが空では投句できない' do
        @haiku.content = ""
        @haiku.valid?
        expect(@haiku.errors.full_messages).to include("俳句を入力してください")
      end
      it 'contentが4文字以下では投句できない' do
        @haiku.content = "あいうえ"
        @haiku.valid?
        expect(@haiku.errors.full_messages).to include("俳句は5文字以上で入力してください")
      end
      it 'contentが空では投句できない' do
        @haiku.content = "あいうえおかきくけこさしすせそたちつてとなにぬねのは"
        @haiku.valid?
        expect(@haiku.errors.full_messages).to include("俳句は25文字以内で入力してください")
      end
      it 'userがひもづいていないと設置できない' do
        @haiku.user = nil
        @haiku.valid?
        expect(@haiku.errors.full_messages).to include("Userを入力してください")
      end
      it 'themeがひもづいていないと設置できない' do
        @haiku.field = nil
        @haiku.valid?
        expect(@haiku.errors.full_messages).to include("Fieldを入力してください")
      end
    end
  end
end
