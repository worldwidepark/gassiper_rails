require 'rails_helper'

describe 'ユーザー管理', type: :system do
  let(:user_a) {FactoryBot.create(:user, name: 'user_a', email: 'user_a@naver.com', password: '123123123')}

  describe 'Sign upとLogin' do
    context 'ユーザーSign up' do
      before do
        visit new_user_registration_path
        fill_in 'Email', with: 'signup-sample@naver.com'
        fill_in 'Password', with: '123123123'
        fill_in 'Password confirmation', with: '123123123'
        fill_in 'Name', with: 'park'
        click_button 'Sign up'
      end

      it 'Sign up成功後、post画面が出る' do

        uri = URI.parse(current_url)
        expect("#{uri.path}").to eq("/posts")
      end
    end

    context 'ユーザーSign up 失敗' do
      let(:login_user) { user_a }
      before do
        visit new_user_registration_path
        fill_in 'Email', with: login_user.email
        fill_in 'Password', with: login_user.password
        fill_in 'Password confirmation', with: login_user.password
        fill_in 'Name', with: ''
        click_button 'Sign up'
      end

      it 'Sign up失敗の後、エラーメッセージが出る。' do
        #deviseのsignup時のエラー生成
        expect(page).to have_content 'Email has already been taken'
        expect(page).to have_content "Name can't be blank"
      end
    end

    context 'ユーザーLogin' do
      let(:login_user) { user_a }

      it 'Login成功後、post画面が出る' do
        visit new_user_session_path
        fill_in 'Email', with: login_user.email
        fill_in 'Password', with: login_user.password
        click_button 'Login'

        uri = URI.parse(current_url)
        expect("#{uri.path}").to eq("/")
      end
    end

    context 'ユーザーLogin 失敗' do
      let(:login_user) { user_a }

      it 'Login失敗の後、エラーが出る。' do
        #パスワード誤入力
        visit new_user_session_path
        fill_in 'Email', with: login_user.email
        fill_in 'Password', with: '123123'
        click_button 'Login'

        expect(page).to have_content "Invalid Email or password."

        #存在しないemailを入力
        visit new_user_session_path
        fill_in 'Email', with: 'therenoemail@email.come'
        fill_in 'Password', with: '123123123'
        click_button 'Login'

        expect(page).to have_content "Invalid Email or password."
      end
    end
  end

  describe 'ユーザー詳細ページの作成' do
    before do
      login(login_user)
    end

    context 'ユーザー編集ページに遷移&編集' do
      let(:login_user) { user_a }

      it 'ユーザー編集ページで編集ができる' do
        click_link 'user_a'
        click_link '編集'
        uri = URI.parse(current_url)
        expect("#{uri.path}").to eq("/users/edit")

        fill_in 'user_name', with: 'user'
        fill_in 'user_introduce', with: '123123123'
        click_button '編集'
        expect(page).to have_content '更新に成功しました。'
      end
    end

    context 'ユーザー詳細編集失敗' do
      let(:login_user) { user_a }

      it '名前未入力で更新失敗' do
        click_link 'user_a'
        click_link '編集'

        fill_in 'user_name', with: ''
        fill_in 'user_introduce', with: '123123123'
        click_button '編集'
        expect(page).to have_content '更新に失敗しました。'
      end
    end

    context '退会' do
      let(:login_user) { user_a }

      it '退会ができる。' do
        click_link 'user_a'
        click_button '退会'
        #退会ができ、root画面に戻る。
        expect(page).to have_content '23万のユーザーが待っています。Log inをしてください。'
        #退会後、再ログインできない。
        login(login_user)
        expect(page).to have_content '退会になられたアカウントです。'
      end
    end

    context '退会後、退会したメールアドレスでSignupできない。' do
      let(:login_user) { user_a }

      before do
        click_link 'user_a'
        click_button '退会'
      end
      it 'Signupができなく、エラーが出る。' do
          visit new_user_registration_path
          fill_in 'Email', with: login_user.email
          fill_in 'Password', with: login_user.password
          fill_in 'Password confirmation', with: login_user.password
          fill_in 'Name', with: login_user.name
          click_button 'Sign up'

          expect(page).to have_content 'Email has already been taken'
      end
    end
  end

  describe '画像アップロード' do
    before do
      login(login_user)
      click_link 'user'
    end

    context 'ユーザー詳細画面で動画アップロード' do
      let(:login_user) { user_a }

      it 'アップロードしてない時はno pictureが表示される。'do
        expect(page).to have_content 'no picture'
      end

      it 'attachされている' do
        click_link '編集'
        attach_file 'user_img', "#{Rails.root}/spec/fixtures/images/test.jpg"
        click_button '編集'
        expect(page).to have_selector("img[src$='test.jpg']")
      end


    end
  end

  describe 'githubログイン' do
    before do
      visit new_user_session_path
      OmniAuth.config.mock_auth[:github] = nil
      Rails.application.env_config['omniauth.auth'] = github_mock('name','email@email.com')
    end

    context 'githubでログイン確認' do
      it 'githubでログインできる。' do
        click_button 'github'
        expect(page.status_code).to eq 200

        uri = URI.parse(current_url)
        expect("#{uri.path}").to eq("/")
      end
    end
  end

  describe 'Follow' do
    context 'Follow機能確認' do
      before do
        user_me = FactoryBot.create(:user, name: 'me', email: 'me@naver.com', password: '123123123')
        user_you = FactoryBot.create(:user, name: 'you', email: 'you@naver.com', password: '123123123')
        @post_you = FactoryBot.create(:post ,text: 'this is me', user_id: user_you.id)
        @post_you_2 = FactoryBot.create(:post ,text: 'this is me no.2', user_id: user_you.id)

        visit new_user_session_path
        fill_in 'Email', with: user_me.email
        fill_in 'Password', with: user_me.password
        click_button 'Login'
        page.first('#user-detail-on-post').click
      end

      it 'FollowとUnfollowができる。' do

        click_button 'follow'
        expect(page).to have_button('unfollow')
        expect(page).to have_content 'フォローしました。'

        click_button 'unfollow'
        expect(page).to have_button('follow')
        expect(page).to have_content 'フォローを解除しました。'

        click_button 'follow'
        click_link 'TOPページ'
        #最近のポストが一番上にくる。
        expect(page.text).to match(/#{@post_you_2.text}[\s\S]*#{@post_you.text}/)
      end

      it '自分のユーザー詳細にはfollowボタンがない。' do
        click_link 'TOPページ'
        click_link 'me'
        expect(page).to have_no_button('unfollow')
        expect(page).to have_no_button('follow')
      end
    end
  end
end
