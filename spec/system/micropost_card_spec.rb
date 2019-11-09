# frozen_string_literal: true

require 'rails_helper'

describe '未ログイン時におけるイラストカードの機能制限', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_micropost) { FactoryBot.create(:other_micropost, user: other_user) }

  describe 'ログイン済みの状態' do
    before do
      sign_in_as user
      visit root_path
    end

    context 'イラストカードのタイトルをクリックしたとき' do
      it '記事参照画面に遷移し、「コメントフォーム」が表示されること' do
        click_link other_micropost.title
        expect(page).to have_css '#form-comment-wrapper'
      end
    end

    context 'イラストカードのユーザー画像をクリックしたとき' do
      it 'ユーザー参照画面に遷移すること' do
        find('.user-image').click
        expect(page).to have_content other_micropost.user.name
      end
    end
  end

  describe 'ログインしていない状態' do
    before do
      visit root_path
    end

    context '記事カードの記事画像をクリックしたとき' do
      it '記事参照画面に遷移し、「コメントフォーム」が表示されないこと' do
        click_link other_micropost.title
        expect(page).not_to have_css '#form-comment-wrapper'
      end
    end
  end
end
