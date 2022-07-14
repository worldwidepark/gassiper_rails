require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    # before do
    #   user_a = FactoryBot.create(:user, name: 'user', email: 'pakr21@naver.com', password: '123123123')
    # end

    context 'ユーザーログイン' do
      before do
        visit new_user_session_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        click_button 'Login'
      end

      it 'post画面が出る' do
        expect(page).to have_content 'Gassiper'
      end
    end
  end
end
