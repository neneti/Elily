require 'rails_helper'

describe 'ログアウト機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in_as user
  end

  context '「ログアウト」をおした場合' do
    it 'ログアウトする' do
      find('#navbarDropdown').click
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end
  end
end
