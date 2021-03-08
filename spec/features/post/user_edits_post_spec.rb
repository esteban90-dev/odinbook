require 'rails_helper'

feature "user edits a post" do 

  context "with new text" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
      @post = @bob.posts.last
      sign_in @bob

      visit root_path
      click_on "bob"
      
      edit_post_with_new_text(@post, "chicken is better than pork")
    end

    scenario "they see the modified post text" do 
      user_sees_modified_post_text(@post, "chicken is better than pork")
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully updated post")
    end

  end

  context "with a new picture" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
      @post = @bob.posts.last
      sign_in @bob

      visit root_path
      click_on "bob"
      
      
      edit_post_with_new_image(@post, "#{Rails.root}/spec/files/white_house.jpg")
    end

    scenario "they see the modified post image" do
      user_sees_modified_post_picture(@post, "white_house.jpg")
    end

    scenario "they see the post text remain unchanged" do 
      user_sees_post_text(@post)
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully updated post")
    end

  end

end