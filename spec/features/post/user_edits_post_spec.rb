require 'rails_helper'

feature "user edits a post" do
  
  context "from their profile" do

    context "with new text" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        @post = @bob.posts.create(body: "this is a post")
        sign_in @bob

        visit root_path
        click_on "bob"

        edit_post_text(@post, "this is different")
      end

      scenario "they are redirected back to their profile" do 
        expect(page).to have_current_path(user_profile_path(@bob))
      end

      scenario "they see the modified post text" do 
        expect(page).to have_content("this is different")
      end

      scenario "they don't see the old text" do 
        expect(page).not_to have_content("this is a post")
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully updated post")
      end

    end

    context "with no text or picture" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        @post = @bob.posts.create(body: "this is a post")
        sign_in @bob

        visit root_path
        click_on "bob"

        edit_post_text(@post, "")
      end

      scenario "they see an error message" do 
        expect(page).to have_content("must have text or picture")
      end

    end

    context "with a different picture" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        post_image_file = fixture_file_upload(Rails.root.join('spec','files','empire_state_building.jpg'), 'image/jpg')
        @post = @bob.posts.create(body: "this is the second post", picture: post_image_file)
        sign_in @bob

        visit root_path
        click_on "bob"

        edit_post_picture(@post, "#{Rails.root}/spec/files/white_house.jpg")
      end

      scenario "they are redirected back to their profile" do 
        expect(page).to have_current_path(user_profile_path(@bob))
      end

      scenario "they see the modified post image" do
        expect(page).to have_image("white_house.jpg")
      end

      scenario "they don't see the old image" do
        expect(page).not_to have_image("empire_state_building.jpg")
      end

      scenario "they see the post text remain unchanged" do 
        expect(page).to have_content("this is the second post")
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully updated post")
      end

    end

  end

  context "from the timeline" do 

    context "with different text" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        @post = @bob.posts.create(body: "this is a post")
        sign_in @bob

        visit root_path
        click_on "timeline"

        edit_post_text(@post, "this is different")
      end

      scenario "they are redirected back to the timeline" do 
        expect(page).to have_current_path(posts_path)
      end

      scenario "they see the modified post text" do 
        expect(page).to have_content("this is different")
      end

      scenario "they don't see the old text" do 
        expect(page).not_to have_content("this is a post")
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully updated post")
      end

    end

    context "with no text or picture" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        @post = @bob.posts.create(body: "this is a post")
        sign_in @bob

        visit root_path
        click_on "timeline"

        edit_post_text(@post, "")
      end

      scenario "they see an error message" do 
        expect(page).to have_content("must have text or picture")
      end

    end

    context "with a different picture" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        post_image_file = fixture_file_upload(Rails.root.join('spec','files','empire_state_building.jpg'), 'image/jpg')
        @post = @bob.posts.create(body: "this is the second post", picture: post_image_file)
        sign_in @bob

        visit root_path
        click_on "timeline"

        edit_post_picture(@post, "#{Rails.root}/spec/files/white_house.jpg")
      end

      scenario "they are redirected back to the timeline" do 
        expect(page).to have_current_path(posts_path)
      end

      scenario "they see the modified post image" do
        expect(page).to have_image("white_house.jpg")
      end

      scenario "they don't see the old image" do
        expect(page).not_to have_image("empire_state_building.jpg")
      end

      scenario "they see the post text remain unchanged" do 
        expect(page).to have_content("this is the second post")
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully updated post")
      end

    end

  end

end