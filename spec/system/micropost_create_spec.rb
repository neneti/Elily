require 'rails_helper'

describe '作品投稿', type: :system do
  before do
    sign_in_as FactoryBot.create(:user)
    visit new_micropost_path
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
      expect(page).to have_content '投稿が完了しました。'
      expect(page).to have_content 'いいいい'
      expect(page).to have_content 'あああああ'
      expect(page).to have_content 'ううう'
    end
  end

  context '項目に不正な値がある' do
    context '必須項目が未入力のとき' do
      before do
        fill_in '詳細', with: 'あああああ'
        fill_in 'タグ', with: 'ううう'
        file_path = Rails.root.join('spec', 'fixtures', 'images', 'test.jpg')
        attach_file 'イラスト', file_path
        click_on '登録'
      end

      it '投稿が登録されないこと' do
        expect(page).to have_content 'タイトルを入力してください'
      end
    end

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
