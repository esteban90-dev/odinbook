require 'rails_helper'

feature "user edits comment" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @bob.friends << @frank
    @bob.posts.create(body: "this is a post")
    @comment = @bob.posts.last.comments.create(body: "this post is okay", commenter: @frank)

    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"
    edit_comment(@comment, "this post is actually great")
  end

  scenario "they don't see the old comment text" do 
    expect(page).not_to have_content("this post is okay")
  end

  scenario "they see the new comment text" do 
    expect(page).to have_content("this post is actually great")
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully updated comment")
  end

end