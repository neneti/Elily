# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
  end

  context '有効な情報を入力したとき' do
    it 'ログインできること' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'プロフィール'
    end
  end

  context '不正な組み合わせを入力したとき' do
    it 'ログインできないこと' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'incorrect'
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスとパスワードが一致しません。'
    end
  end

  context '未入力のとき' do
    it 'ログインできないこと' do
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスとパスワードが一致しません。'
    end
  end
end
