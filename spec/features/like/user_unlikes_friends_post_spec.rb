require 'rails_helper'

feature "user unlikes a friend's post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
    @frank.friends << @bob
    @post = @bob.posts.create(body: "this is a post")
    @post.likes.create(liker: @frank)
    sign_in @frank

    visit root_path
    click_on "frank"
    click_on "friends"
    click_on "bob"
    find("##{@post.id}").click_on "unlike"
  end

  scenario "the user sees the like count decrement" do 
    expect(page).to have_css("##{@post.id}", text: "likes: 0")
  end

  scenario "the user doesn't see the 'unlike' button anymore" do 
    expect(page).not_to have_link("unlike")
  end

  scenario "the user now sees the like button" do 
    expect(page).to have_link("like")
  end

end