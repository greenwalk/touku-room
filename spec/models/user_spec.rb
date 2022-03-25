require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it '全ての項目を入力すれば登録ができる' do
      expect(@user).to be_valid
    end
    it 'プロフィールが空でも登録できる' do
      @user.profile = ""
      expect(@user).to be_valid
    end
    it 'メールアドレスが空では登録できない' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end
    it 'パスワードが空では登録できない' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'パスワードと確認用パスワードが一致しなければ登録できない' do
      @user.password_confirmation = "test1234"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'パスワードが8文字以上でないと登録できない' do
      @user.password = "test123"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは8文字以上で入力してください")
    end
    it 'パスワードが128文字以下でないと登録できない' do
      @user.password = "test1234000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
    end
    it '英字のみのpasswordでは登録できない' do
      @user.password = 'aaaaaaaa'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です")
    end
    it '数字のみのpasswordでは登録できない' do
      @user.password = '11111111'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です")
    end
    it '全角文字を含むpasswordでは登録できない' do
      @user.password = 'tstps１２３'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です")
    end
    it '俳号が空では登録できない' do
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("俳号を入力してください")
    end
  end
end
