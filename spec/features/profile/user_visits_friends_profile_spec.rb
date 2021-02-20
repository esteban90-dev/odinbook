require 'rails_helper'

feature "user visits friend's profile" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, :with_blank_profile, name: "frank", email: "frank@example.com")
    @frank.friends << @bob
    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"
  end

  scenario "they see their friend's posts in descending order" do 
    post_1 = @bob.posts.first.body
    post_2 = @bob.posts.second.body

    user_sees_friends_posts_in_desc_order(post_1, post_2)
  end

  scenario "they don't see a form to create a post" do 
    user_doesnt_see_post_form
  end

end