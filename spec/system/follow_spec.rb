require 'rails_helper'

describe 'フォロー機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }
  let(:relationship) do
    FactoryBot.create(:relationship, follower: user, followed: other_user)
  end

  describe 'ユーザー参照画面' do
    context '「フォロー」をクリックしたとき' do
      before do
        sign_in_as user
        visit user_path(other_user)
        click_on 'フォロー'
      end

      it '「フォロー中」に変わること' do
        expect(page).to have_css('.unfollow-btn')
      end
    end

    context '「フォロー中」をクリックしたとき' do
      before do
        relationship
        sign_in_as user
        visit user_path(other_user)
        click_on 'フォロー中'
      end

      it '「フォロー」に変わること' do
        expect(page).to have_css('.follow-btn')
      end
    end
  end

  describe 'ユーザー一覧画面' do
    context '「フォロー」をクリックしたとき' do
      before do
        sign_in_as user
        visit users_path
        find("#follow-form-#{other_user.id}").click_on 'フォロー'
      end

      it '「フォロー中」に変わること' do
        expect(page).to have_css('.unfollow-btn')
      end
    end

    context '「フォロー中」をクリックしたとき' do
      before do
        relationship
        sign_in_as user
        visit users_path
        find("#follow-form-#{other_user.id}").click_on 'フォロー中'
      end

      it '「フォロー」に変わること' do
        expect(page).to have_css('.follow-btn')
      end
    end
  end
end
