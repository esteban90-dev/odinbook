require 'rails_helper'

feature "user makes a post" do 

  context "with text only" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_blank_profile, name: "bob", email: "bob@example.com")
      sign_in @bob

      visit root_path
      click_on "bob"
      fill_in "Body", with: "this is my first post"
      click_on "create post"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully made a post")
    end

    scenario "they see the posted text appear on their profile" do 
      post = @bob.posts.first

      user_sees_post_text(post)
    end

  end

  context "with text and an image" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_blank_profile, name: "bob", email: "bob@example.com")
      sign_in @bob

      visit root_path
      click_on "bob"
      fill_in "Body", with: "this is my first post"
      attach_file "Picture", "#{Rails.root}/spec/files/empire_state_building.jpg"
      click_on "create post"
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully made a post")
    end

    scenario "they see the posted text appear on their profile" do 
      post = @bob.posts.first

      user_sees_post_text(post)
    end

    scenario "they see the posted image appear on their profile" do 
      post = @bob.posts.first

      user_sees_post_picture(post)
    end

  end

end