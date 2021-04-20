require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが６文字以上であれば登録できる' do
        @user.password = '12345a'
        @user.password_confirmation = '12345a'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'emailは一意性でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含めないと登録できない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワードには半角英数混合で入力してください', 'パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'passwordが５文字以下であれば登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください', 'パスワードには半角英数混合で入力してください')
      end
      it 'passwordとpassword_confirmationの値が一致していないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません', 'パスワードには半角英数混合で入力してください')
      end
      it 'passwordは半角英語のみは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英数混合で入力してください')
      end
      it 'passwordは数字のみは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英数混合で入力してください')
      end
      it 'passwordは全角英数混合のみは登録できない' do
        @user.password = '１１１１１a'
        @user.password_confirmation = '１１１１１a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには半角英数混合で入力してください')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字を入力してください', '名字は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください', '名前は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（フリガナ）を入力してください', '名字（フリガナ）は全角で入力してください')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（フリガナ）を入力してください', '名前（フリガナ）は全角で入力してください')
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）以外は登録できない' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_name_kanaは全角（カタカナ）以外は登録できない' do
        @user.last_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（フリガナ）は全角で入力してください')
      end
      it 'first_name_kanaは全角（カタカナ）以外は登録できない' do
        @user.first_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（フリガナ）は全角で入力してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('誕生日を入力してください')
      end
    end
  end
end
