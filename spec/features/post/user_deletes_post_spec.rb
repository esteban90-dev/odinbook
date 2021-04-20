require 'rails_helper'

feature "user deletes a post" do 

  context "from their profile" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
      @post = @bob.posts.create(body: "this is a post")

      sign_in @bob
      visit root_path 
      find(nav_section).click_on "bob"

      delete_post(@post)
    end

    scenario "they are redirected back to their profile" do 
      expect(page).to have_current_path(user_profile_path(@bob))
    end
    
    scenario "they no longer see the post" do 
      expect(page).not_to have_content("this is a post")
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Post successfully destroyed")
    end

  end

  context "from the timeline" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
      @post = @bob.posts.create(body: "this is a post")

      sign_in @bob
      visit root_path 
      click_on "timeline"

      delete_post(@post)
    end

    scenario "they are redirected back to the timeline" do 
      expect(page).to have_current_path(posts_path)
    end
    
    scenario "they no longer see the post" do 
      expect(page).not_to have_content("this is a post")
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Post successfully destroyed")
    end

  end

end