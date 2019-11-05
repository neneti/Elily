require 'rails_helper'

describe '投稿詳細参照', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user) }
  let!(:other_micropost) { FactoryBot.create(:other_micropost, user: other_user) }

  shared_examples_for '「編集」「削除」が表示されること' do
    it {
      expect(page).to have_content '編集'
      expect(page).to have_content '削除'
    }
  end

  shared_examples_for '「編集」「削除」が表示されないこと' do
    it {
      expect(page).not_to have_content '編集'
      expect(page).not_to have_content '削除'
    }
  end

  describe 'ログイン後の状態' do
    before do
      sign_in_as user
    end

    context 'ログインユーザーの投稿を参照したとき' do
      before do
        visit micropost_path(micropost)
      end

      it '投稿内容が正しく表示されること' do
        expect(page).to have_content micropost.title
        expect(page).to have_content micropost.content
      end

      it_behaves_like '「編集」「削除」が表示されること'
    end

    context 'ログインユーザー以外の投稿を参照したとき' do
      before do
        visit micropost_path(other_micropost)
      end

      it '投稿内容が正しく表示されること' do
        expect(page).to have_content other_micropost.title
        expect(page).to have_content other_micropost.content
      end

      it_behaves_like '「編集」「削除」が表示されないこと'
    end
  end

  describe 'ログインしていない状態' do
    context '投稿を参照したとき' do
      before do
        visit micropost_path(micropost)
      end

      it '投稿内容が正しく表示されること' do
        expect(page).to have_content micropost.title
        expect(page).to have_content micropost.content
      end

      it_behaves_like '「編集」「削除」が表示されないこと'
    end
  end
end
