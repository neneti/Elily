# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザ情報変更機能', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in_as user
    visit edit_user_path(user)
  end

  describe 'プロフィール情報変更' do
    context '正しい情報を入力したとき' do
      it 'プロフィール情報の変更ができること' do
        file_path = Rails.root.join('spec', 'fixtures', 'images', 'avatar2.jpg')
        attach_file 'プロフィール画像', file_path
        fill_in '名前', with: 'あああ'
        fill_in 'プロフィール', with: 'いいい'
        fill_in 'メールアドレス', with: 'test111@example.com'
        fill_in 'パスワード', with: 'newpassword'
        fill_in 'パスワード（確認）', with: 'newpassword'
        click_button '更新'
        expect(page).to have_content 'プロフィールを更新しました。'
      end
    end

    context '正しい情報を入力したとき' do
      it 'パスワード未入力でも変更ができること' do
        fill_in '名前', with: 'あああ'
        fill_in 'プロフィール', with: 'いいい'
        fill_in 'メールアドレス', with: 'test111@example.com'
        click_button '更新'
        expect(page).to have_content 'プロフィールを更新しました。'
      end
    end
  end

  describe '不正な情報' do
    context 'ユーザーネームがないとき' do
      it '更新できないこと' do
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: 'test111@example.com'
        click_button '更新'
        expect(page).to have_content 'ユーザーネームを入力してください'
      end
    end

    context 'メールアドレスがないとき' do
      it '更新できないこと' do
        fill_in '名前', with: 'ユーザー変更後'
        fill_in 'メールアドレス', with: ''
        click_button '更新'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end

    context '確認用パスワードが異なるとき' do
      it '更新できないこと' do
        fill_in 'パスワード', with: 'newpassword'
        fill_in 'パスワード（確認）', with: 'newpassword2'
        click_button '更新'
        expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
      end
    end
  end
end
