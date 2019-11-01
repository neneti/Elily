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
    end
  end
end
