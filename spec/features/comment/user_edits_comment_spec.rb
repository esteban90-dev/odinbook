require 'rails_helper'

feature "user edits comment" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @bob.friends << @frank
    @comment = @bob.posts.last.comments.create(body: "this post is okay", commenter: @frank)

    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"

    edit_comment(@comment, "this post is actually great")
  end

  scenario "they see the modified comment" do 
    user_sees_post_comment(@comment.post, "this post is actually great")
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully updated comment")
  end

end