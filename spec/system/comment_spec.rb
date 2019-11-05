require 'rails_helper'

describe 'コメント機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_micropost) { FactoryBot.create(:other_micropost, user: other_user) }
  let(:comment) { FactoryBot.create(:comment, user: user, micropost: other_micropost) }

  before do
    sign_in_as user
    visit micropost_path(other_micropost)
  end

  shared_examples_for 'コメントが投稿されないこと' do
    it {
      expect(page).to have_content 'コメントできませんでした'
    }
  end

  describe '投稿詳細参照画面' do
    context 'コメントを正しく登録したとき' do
      before do
        fill_in 'コメント（50文字以内）', with: 'コメント'
        click_on '送信'
      end

      it 'コメントが表示されること' do
        expect(page).to have_content 'コメント'
      end
    end

    context 'コメントを文字数オーバーで登録したとき' do
      before do
        fill_in 'コメント（50文字以内）', with: ('a' * 51)
        click_on '送信'
      end

      it_behaves_like 'コメントが投稿されないこと'
    end

    context 'コメント未入力で登録したとき' do
      before do
        click_on '送信'
      end

      it_behaves_like 'コメントが投稿されないこと'
    end
  end

  describe '投稿詳細参照画面' do
    context 'コメントを削除したとき' do
      before do
        fill_in 'コメント（50文字以内）', with: 'テストコメント'
        click_on '送信'
        click_on '削除'
      end

      it 'コメントが削除されること' do
        expect(page).to have_no_content 'テストコメント'
      end
    end
  end
end
