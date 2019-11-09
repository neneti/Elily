# frozen_string_literal: true

require 'rails_helper'

describe 'お気に入り機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let!(:other_micropost) { FactoryBot.create(:other_micropost, user: other_user) }
  let(:like) do
    FactoryBot.create(:like, user: user, micropost: other_micropost)
  end

  describe '記事詳細参照画面' do
    context '無効状態のハートマークをクリックしたとき' do
      before do
        sign_in_as user
        visit micropost_path(other_micropost)
        find('#like-btn').click
      end

      it 'ハートマークが有効状態になること' do
        expect(page).to have_content '1'
      end
    end
  end
end
