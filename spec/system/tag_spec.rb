require 'rails_helper'

describe 'タグ検索', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_micropost) { FactoryBot.create(:other_micropost, user: other_user) }

  before do
    sign_in_as user
    visit microposts_path(tag_name: "#")
  end

  describe '検索成功' do
    context '存在するタグで検索したとき' do
      it 'ヒットした投稿が表示されること' do
        fill_in 'tag_name', with: 'tag1'
        click_on '検索'
        expect(page).to have_content other_micropost.title
      end
    end
  end

  describe '検索失敗' do
    context '存在しないタグで検索したとき' do
      it '投稿が表示されないこと' do
        fill_in 'tag_name', with: 'ああああああ'
        click_on '検索'
        expect(page).to have_content '該当するイラストが見つかりませんでした。'
      end
    end
  end
end
