require 'rails_helper'

feature "user deletes comment" do 

  context "from their profile" do 

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

      delete_comment(@comment)
    end

    scenario "they are redirected back to their profile" do 
      expect(page).to have_current_path(user_profile_path(@bob))
    end

    scenario "they see that the comment is no longer there" do 
      expect(page).not_to have_content("this post could be better")
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully deleted comment")
    end

  end

  context "from the timeline" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
      @bob.friends << @frank
      @post = @bob.posts.create(body: "this is a post")
      @comment = @post.comments.create(body: "this post could be better", commenter: @frank)

      sign_in @frank
      visit root_path
      click_on "timeline"

      delete_comment(@comment)
    end

    scenario "they are redirected back to the timeline" do 
      expect(page).to have_current_path(posts_path)
    end

    scenario "they see that the comment is no longer there" do 
      expect(page).not_to have_content("this post could be better")
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully deleted comment")
    end

  end

end