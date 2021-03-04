require 'rails_helper'

feature "user comments on friend's post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @bob.friends << @frank
    @post = @bob.posts.last

    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"

    comment_on_post(@post, "this post is great")
  end

  scenario "they see the comment appear below the post" do
    user_sees_post_comment(@post.comments.first)
  end

  scenario "they see their name appear as a link back to their profile next to their comment" do 
    user_sees_name_with_comment(@post.comments.first)
  end

  scenario "the post's author receives a notification" do 
    sign_out @frank
    sign_in @bob

    visit root_path
    click_on "notifications"

    post_author_receives_comment_notification(@post, @post.comments.first)
  end

end