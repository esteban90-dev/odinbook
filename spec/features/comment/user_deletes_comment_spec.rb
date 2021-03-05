require 'rails_helper'

feature "user deletes comment" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @bob.friends << @frank
    @comment = @bob.posts.last.comments.create(body: "this post could be better", commenter: @frank)

    sign_in @frank
    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"

    delete_comment_from_post(@comment)
  end

  scenario "they see that the comment is no longer there" do 
    user_sees_post_comment_missing(@comment.post, @comment.body)
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully deleted comment")
  end

end