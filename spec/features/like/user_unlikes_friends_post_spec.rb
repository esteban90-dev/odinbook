require 'rails_helper'

feature "user unlikes a friend's post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @frank.friends << @bob
    @bob.posts.last.likes.create(liker: @frank)
    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"
    @post = @bob.posts.last
    unlike(@post)
  end

  scenario "the user sees the like count decrement" do 
    user_sees_post_with_likes(@post, 0)
  end

  scenario "the user sees the 'unlike' button become an 'like' button" do 
    user_sees_post_like_button(@post)
  end

end