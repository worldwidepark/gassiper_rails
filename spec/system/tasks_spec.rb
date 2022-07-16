require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe 'ユーザーSign upとLog in' do

    context 'ユーザーSign up' do
      before do
        visit new_user_registration_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        fill_in 'Password confirmation', with: '123123123'
        fill_in 'Name', with: 'park'
        click_button 'Sign up'
      end

      it 'root_pathのpost画面が出る' do
        uri = URI.parse(current_url)
        expect("#{uri.path}").to eq("/posts")
      end
    end

    context 'ユーザーLogin' do
      before do
        user_a = FactoryBot.create(:user, name: 'user', email: 'pakr21@naver.com', password: '123123123')
        visit new_user_session_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        click_button 'Login'
      end

      it 'root_pathのpost画面が出る' do
        uri = URI.parse(current_url)
        expect("#{uri.path}").to eq("/")
      end
    end
  end
end
