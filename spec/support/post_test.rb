module PostTest

  def post(post_text)
    click_link 'つぶやき'
    fill_in 'post_text', with: post_text
    click_button '投稿'
  end

  def comment(comment_text)
    click_link 'Comment'
    fill_in 'comment_text', with: comment_text
    click_button '投稿'
  end

end

