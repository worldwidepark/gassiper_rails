require 'rails_helper'

describe 'ユーザー管理', type: :system do
  let(:user_a) {FactoryBot.create(:user, name: 'user_a', email: 'user_a@naver.com', password: '123123123')}

  describe 'PostとComment' do
    before do
      login(login_user)
    end

    context 'Post 作成' do
      let(:login_user) { user_a }

      it 'post作成し、トップページに表示する。' do
        click_link 'つぶやき'
        fill_in 'post_text', with: 'this is post test'
        click_button '投稿'
        expect(page).to have_content 'this is post test'
      end

      it 'postが140文字異常だとエラーになる。。' do
        click_link 'つぶやき'
        fill_in 'post_text', with: 'this is post testthis is post testthis is post testthis is post testthis is post testthis is post testthis is post testthis is post testthis is post testthis is post test'
        click_button '投稿'
        expect(page).to have_content 'Text is too long (maximum is 140 characters)'
      end
    end


    context 'Comment 作成' do
      let(:login_user) { user_a }

      before do
        post('this is post test')
        expect(page).to have_content 'this is post test'
      end

      it 'Commentを作成し、Post詳細ページに表示する。' do
        click_link 'this is post test'
        click_link 'Comment'
        fill_in 'comment_text', with: 'this is comment test'
        click_button '投稿'
        expect(page).to have_content 'this is comment test'
      end
    end
  end

  describe 'PostとCommentのlike' do
    before do
      login(login_user)
    end

    context 'Post Like' do
      let(:login_user) { user_a }
      before do
        post('this is post test')
      end

      it 'Like機能確認' do
        find('#like').click
        expect(page).to have_selector '#unlike'

        #ユーザー詳細ページでいいねしたポストを見れる
        click_link 'user-detail'
        expect(page).to have_content 'this is post test'
        #ユーザー詳細ページでいいねしたポストが#unlikeを持っている
        expect(page).to have_selector '#unlike'
      end
    end

    context 'Comment Like' do
      let(:login_user) { user_a }
      before do
        post('this is post test')
        click_link 'this is post test'
        comment('this is comment test')
      end

      it 'Like機能確認' do
        find('#like-comment').click
        expect(page).to have_selector '#unlike-comment'
        click_link 'TOPページ'
        click_link 'user-detail'
        #user詳細ページでいいねしたコメントを見れる
        expect(page).to have_content 'this is comment test'
        #ユーザー詳細ページでいいねしたコメントが#unlike-commentを持っている
        expect(page).to have_selector '#unlike-comment'
      end
    end
  end
end
