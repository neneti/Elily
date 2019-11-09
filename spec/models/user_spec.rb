# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションの確認' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:other_user) { FactoryBot.create(:other_user) }

    describe '有効' do
      context '必須項目が全て存在するとき' do
        it 'ユーザーが有効となること' do
          expect(user).to be_valid
        end
      end
    end

    describe '無効' do
      context 'ユーザ名が存在しないとき' do
        it 'ユーザーが無効となること' do
          user.name = nil
          expect(user).not_to be_valid
        end
      end

      context 'ユーザ名が文字数オーバーのとき' do
        it 'ユーザーが無効となること' do
          user.name = 'a' * 21
          expect(user).not_to be_valid
        end
      end

      context 'メールアドレスが重複しているとき' do
        it 'ユーザーが無効となること' do
          other_user.email = 'test000@example.com'
          expect(other_user).not_to be_valid
        end
      end

      context 'パスワードが最低文字数を未満のとき' do
        it 'ユーザーが無効となること' do
          user.password = 'ppppp'
          user.password_confirmation = 'ppppp'
          expect(user).not_to be_valid
        end
      end

      context 'プロフィールが文字数オーバーのとき' do
        it 'ユーザーが無効となること' do
          user.profile = 'a' * 151
          expect(user).not_to be_valid
        end
      end
    end
  end
end
