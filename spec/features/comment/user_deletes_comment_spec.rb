require 'rails_helper'

feature "user deletes comment" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @bob.friends << @frank
    @post = @bob.posts.create(body: "this is a post")
    @comment = @post.comments.create(body: "this post could be better", commenter: @frank)

    sign_in @frank
    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"

    find(".comment##{@comment.id}").click_on "delete"
  end

  scenario "they see that the comment is no longer there" do 
    expect(page).not_to have_content("this post could be better")
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Successfully deleted comment")
  end

end