require 'rails_helper'

feature "user edits comment" do 

  context "from friend's profile" do 

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

    scenario "they are redirected back to the friend's profile" do 
      expect(page).to have_current_path(user_profile_path(@bob))
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

  context "from the timeline" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
      @bob.friends << @frank
      @bob.posts.create(body: "this is a post")
      @comment = @bob.posts.last.comments.create(body: "this post is okay", commenter: @frank)

      sign_in @frank

      visit root_path
      click_on "timeline"
      edit_comment(@comment, "this post is actually great")
    end

    scenario "they are redirected back to the timeline" do 
      expect(page).to have_current_path(posts_path)
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

end