require 'rails_helper'

describe '正常系', type: :system do
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

      it 'post画面が出る' do
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

  describe 'ユーザー詳細ページの作成' do
    context 'ユーザー編集ページに遷移' do
      before do
        user_a = FactoryBot.create(:user, name: 'user', email: 'pakr21@naver.com', password: '123123123')
        visit new_user_session_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        click_button 'Login'
      end
      it 'root_pathのpost画面が出る' do
        click_link 'user'
        click_link '編集'
        uri = URI.parse(current_url)
        expect("#{uri.path}").to eq("/users/edit")

        fill_in 'user_name', with: 'user'
        fill_in 'user_introduce', with: '123123123'
        click_button '編集'
        expect(page).to have_content '更新に成功しました。'
      end
    end

    context '脱退' do
      before do
        user_a = FactoryBot.create(:user, name: 'user', email: 'pakr21@naver.com', password: '123123123')
        visit new_user_session_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        click_button 'Login'
      end
      it 'root_pathのpost画面が出る' do
        click_link 'user'
        click_button '退会'
        expect(page).to have_content '23万のユーザーが待っています。Log inをしてください。'

        visit new_user_session_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        click_button 'Login'

        expect(page).to have_content '退会になられたアカウントです。'
      end
    end

  end


  describe 'PostとComment' do
    context 'Post 作成' do
      before do
        user_a = FactoryBot.create(:user, name: 'user', email: 'pakr21@naver.com', password: '123123123')
        visit new_user_session_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        click_button 'Login'
      end
      it 'post作成し、トップページに表示する。' do

        click_link 'つぶやき'
        fill_in 'post_text', with: 'this is post test'
        click_button '投稿'
        expect(page).to have_content 'this is post test'

        click_link 'this is post test'
        click_link 'Comment'
        fill_in 'comment_text', with: 'this is comment test'
        click_button '投稿'

        expect(page).to have_content 'this is comment test'
      end
    end
  end



  describe '画像アップロード' do
    before do
      user_a = FactoryBot.create(:user, name: 'user', email: 'pakr21@naver.com', password: '123123123')
      visit new_user_session_path
      fill_in 'Email', with: 'pakr21@naver.com'
      fill_in 'Password', with: '123123123'
      click_button 'Login'
      click_link 'user'

    end

    it 'attachされている' do
      click_link '編集'
      attach_file 'user_img', "#{Rails.root}/spec/fixtures/images/test.jpg"
      click_button '編集'
      expect(page).to have_selector("img[src$='test.jpg']")

    end
  end

  describe 'githubログイン' do
    user_a = FactoryBot.create(:user, name: 'user', email: 'pakr121@naver.com', password: '123123123')

    before do
      visit new_user_session_path
      OmniAuth.config.mock_auth[:github] = nil
      Rails.application.env_config['omniauth.auth'] = github_mock('user','pakr121@naver.com')
      click_button 'github'
    end

    it 'should succeed' do
      expect(page.status_code).to eq 200

      uri = URI.parse(current_url)
      expect("#{uri.path}").to eq("/")
    end
  end


  describe 'PostとCommentのlike' do
    context 'Post Like' do
      before do
        visit new_user_registration_path
        fill_in 'Email', with: 'pakr21@naver.com'
        fill_in 'Password', with: '123123123'
        fill_in 'Password confirmation', with: '123123123'
        fill_in 'Name', with: 'park'
        click_button 'Sign up'
        click_link 'つぶやき'
        fill_in 'post_text', with: 'this is post test'
        click_button '投稿'
      end
      it 'post作成し、トップページに表示する。' do
        find('#like').click
        expect(page).to have_selector '#unlike'

        click_link 'this is post test'
        click_link 'Comment'
        fill_in 'comment_text', with: 'this is comment test'
        click_button '投稿'

        find('#like-comment').click
        expect(page).to have_selector '#unlike-comment'
        # expect(page).to have_content 'this is comment test'
      end
    end
  end
end
