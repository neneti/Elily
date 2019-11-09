# frozen_string_literal: true

require 'rails_helper'

describe '投稿編集・削除', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }

  before do
    sign_in_as user
    visit micropost_path(micropost)
  end

  describe '編集処理' do
    before do
      click_link '編集'
    end

    context '全ての項目に正しく入力したとき' do
      before do
        fill_in 'タイトル', with: 'いいいい'
        fill_in '詳細', with: 'あああああ'
        fill_in 'タグ', with: 'ううう'
        file_path = Rails.root.join('spec', 'fixtures', 'images', 'test2.jpg')
        attach_file 'イラスト', file_path
        click_on '登録'
      end

      it '投稿が正しく登録されること' do
        expect(page).to have_content '投稿を更新しました。'
        expect(page).to have_content 'いいいい'
        expect(page).to have_content 'あああああ'
        expect(page).to have_content 'ううう'
      end
    end

    context '項目に不正な値がある' do
      context '項目の上限文字数を超えて入力したとき' do
        before do
          fill_in 'タイトル', with: 'いいいい'
          fill_in '詳細', with: ('a' * 121)
          fill_in 'タグ', with: 'ううう'
          file_path = Rails.root.join('spec', 'fixtures', 'images', 'test.jpg')
          attach_file 'イラスト', file_path
          click_on '登録'
        end

        it '投稿が登録されないこと' do
          expect(page).to have_content '詳細は120文字以内で入力してください'
        end
      end
    end
  end
end
