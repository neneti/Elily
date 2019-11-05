require 'rails_helper'

describe '投稿検索', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_micropost) { FactoryBot.create(:other_micropost, user: other_user) }

  before do
    sign_in_as user
    visit microposts_path
  end

  describe '検索成功' do
    context '存在するタイトルで検索したとき' do
      it 'ヒットした投稿が表示されること' do
        fill_in 'タイトル', with: other_micropost.title
        click_on '検索'
        expect(page).to have_content other_micropost.title
      end
    end

    context '投稿日で検索したとき' do
      it 'ヒットした投稿が表示されること' do
        fill_in '投稿日', with: "2019/11/01"
        click_on '検索'
        expect(page).to have_content other_micropost.title
      end
    end
  end

  describe '検索失敗' do
    context '存在しないタイトルで検索したとき' do
      it '投稿が表示されないこと' do
        fill_in 'タイトル', with: '存在しないタイトル'
        click_on '検索'
        expect(page).to have_content '該当するイラストが見つかりませんでした。'
      end
    end

    context '投稿日より後の日付で検索したとき' do
      it 'ヒットした記事が表示されないこと' do
        fill_in '投稿日', with: "2020/11/01"
        click_on '検索'
        expect(page).to have_content '該当するイラストが見つかりませんでした。'
      end
    end
  end
end
