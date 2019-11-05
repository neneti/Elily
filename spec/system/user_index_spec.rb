require 'rails_helper'

describe 'ユーザー一覧・検索', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }

  before do
    sign_in_as user
    visit users_path
  end

  describe 'ユーザー一覧' do
    context 'ユーザー一覧を表示したとき' do
      it '全てのユーザーが表示されること' do
        expect(page).to have_content user.name
        expect(page).to have_content other_user.name
      end
    end

    context 'ユーザー一覧でユーザー名をクリックしたとき' do
      it 'ユーザー参照画面が表示されること' do
        click_link other_user.name
        expect(page).to have_content other_user.name
        expect(page).to have_content other_user.profile
        expect(page).to have_content '新着作品'
      end
    end
  end

  describe 'ユーザー検索' do
    before do
      sign_in_as user
      visit users_path
    end

    context '存在するユーザーで検索したとき' do
      it 'ヒットしたユーザーが表示されること' do
        fill_in 'ユーザー名を入力', with: other_user.name
        click_on '検索'
        expect(page).to have_content other_user.name
      end
    end

    context '存在しないユーザーで検索したとき' do
      it 'ユーザーが表示されないこと' do
        fill_in 'ユーザー名を入力', with: '存在しないユーザー'
        click_on '検索'
        expect(page).to have_content '該当するユーザーが見つかりませんでした。'
        expect(page).not_to have_content user.name
        expect(page).not_to have_content other_user.name
      end
    end

    context '「全てのユーザー」をクリックしたとき' do
      it '全ユーザーが表示されること' do
        click_on '全てのユーザー'
        expect(page).to have_content user.name
        expect(page).to have_content other_user.name
      end
    end
  end
end
