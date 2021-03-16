require 'rails_helper'

feature "user comments on friend's post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @bob.friends << @frank
    @post = @bob.posts.create(body: "this is a post")

    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"

    within("[data-test=post-#{@post.id}]") do 
      fill_in "comment_body", with: "this post is great"
      click_on "comment"
    end
  end

  scenario "they see the comment" do
    expect(page).to have_content("this post is great")
  end

  scenario "they see their name appear next to the comment" do 
    within("[data-test=comment-#{@post.comments.first.id}]") do 
      expect(page).to have_content("frank")
    end
  end

  scenario "they click their name next to the comment and it leads them back to their profile" do 
    find("[data-test=comment-#{@post.comments.first.id}]").click_on "frank"

    expect(page).to have_current_path(user_profile_path(@frank.id))
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully created comment")
  end

  scenario "the post's author receives a notification" do 
    sign_out @frank
    sign_in @bob

    visit root_path
    click_on "notifications"

    expect(page).to have_content("frank commented on your post")
  end

  scenario "the post's author clicks the link in the notification and it leads them back to the post" do 
    sign_out @frank
    sign_in @bob

    visit root_path
    click_on "notifications"
    click_on "post"

    expect(page).to have_content("this is a post")
  end

end