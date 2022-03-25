require 'rails_helper'

RSpec.describe Theme, type: :model do
  before do
    @theme = FactoryBot.build(:theme)
  end
  describe 'お題設定機能' do
    context '設定できる場合' do
      it '全ての情報を入力したら設定できる' do
        expect(@theme).to be_valid
      end
    end
    context '設定できない場合' do
      it '画像がないと設定できない' do
        @theme.image = nil
        @theme.valid?
        expect(@theme.errors.full_messages).to include("お題画像を入力してください")
      end
      it '画像の拡張子が適切でないと設定できない' do
        @theme.image = nil
        @theme.image.attach(io: File.open('public/images/theme_test.ico'), filename: 'theme_test.ico')
        @theme.valid?
        expect(@theme.errors.full_messages).to include("お題画像に使用可能な拡張子は .png/.jpg/.jpeg のみです")
      end
      it '季節が空では出品できない' do
        @theme.season_id = 1
        @theme.valid?
        expect(@theme.errors.full_messages).to include("季節を選択してください")
      end
    end
  end
end
