require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる' do
      it 'nicknameとemailとpasswordとfirst_nameとlast_nameとfirst_name_kanaとlast_name_kanaとbirthdayが存在していれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない' do
      it 'nicknameが存在していないと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが存在していないと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'last_nameが存在していないと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください")
      end

      it 'first_nameが存在していないと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください")
      end

      it 'last_name_kanaが存在していないと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（全角カナ）を入力してください")
      end

      it 'first_name_kanaが存在していないと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名（全角カナ）を入力してください")
      end

      it 'birthdayが存在していないと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end

      it 'emailが重複していると登録できない' do
        @user.save
        other_user = FactoryBot.build(:user)
        other_user.email = @user.email
        other_user.valid?
        expect(other_user.errors.full_messages).to include("Eメールはすでに存在します")
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード半角英数字で設定してください")
      end

      it 'passwordが半角数値のみでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード半角英数字で設定してください")
      end

      it 'passwordが全角文字を含むと登録できない' do
        @user.password = 'ａａａａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード半角英数字で設定してください")
      end

      it 'passwordはを5文字以下では登録できない' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordはを128文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, special_characters: false, mix_case: false)
        @user.valid?
        expect(@user.errors.full_messages).to include( "パスワードは128文字以内で入力してください")
      end

      it 'passwordが確認用passwordと一致しないと登録できない' do
        @user.save
        other_user = FactoryBot.build(:user)
        other_user.password = @user.password
        other_user.valid?
        expect(other_user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'last_nameに英数字が含まれると登録できない' do
        @user.last_name = Faker::Internet.password(min_length: 10)
        @user.valid?
        expect(@user.errors.full_messages).to include("姓全角文字を使用してください")
      end

      it 'first_nameに英数字が含まれると登録できない' do
        @user.first_name = Faker::Internet.password(min_length: 10)
        @user.valid?
        expect(@user.errors.full_messages).to include("名全角文字を使用してください")
      end

      it 'last_name_kanaに漢字、英数字が含まれると登録できない' do
        test_name = Faker::Internet.password(min_length: 10)
        @user.last_name_kana = "#{test_name}漢かん"
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（全角カナ）全角カナ文字を使用してください")
      end

      it 'first_name_kanaに漢字、英数字が含まれると登録できない' do
        test_name = Faker::Internet.password(min_length: 10)
        @user.first_name_kana = "#{test_name}漢かん"
        @user.valid?
        expect(@user.errors.full_messages).to include("名（全角カナ）全角カナ文字を使用してください")
      end
    end
  end
end
