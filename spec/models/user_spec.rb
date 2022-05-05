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
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが存在していないと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'last_nameが存在していないと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが存在していないと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_name_kanaが存在していないと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが存在していないと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'birthdayが存在していないと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'emailが重複していると登録できない' do
        @user.save
        other_user = FactoryBot.build(:user)
        other_user.email = @user.email
        other_user.valid?
        expect(other_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordはを5文字以下では登録できない' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordはを128文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, special_characters: false, mix_case: false)
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordが確認用passwordと一致しないと登録できない' do
        @user.save
        other_user = FactoryBot.build(:user)
        other_user.password = @user.password
        other_user.valid?
        expect(other_user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameに英数字が含まれると登録できない' do
        @user.last_name = Faker::Internet.password(min_length: 10)
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end

      it 'first_nameに英数字が含まれると登録できない' do
        @user.first_name = Faker::Internet.password(min_length: 10)
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it 'last_name_kanaに漢字、英数字が含まれると登録できない' do
        test_name = Faker::Internet.password(min_length: 10)
        @user.last_name_kana = "#{test_name}漢かん"
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カナ文字を使用してください')
      end

      it 'first_name_kanaに漢字、英数字が含まれると登録できない' do
        test_name = Faker::Internet.password(min_length: 10)
        @user.first_name_kana = "#{test_name}漢かん"
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カナ文字を使用してください')
      end
    end
  end
end
