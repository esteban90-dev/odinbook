require 'rails_helper'

feature "user makes a post" do 

  context "from their profile" do 

    context "with text only" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "bob"
        fill_in "Body", with: "this is my first post"
        click_on "Create Post"
      end

      scenario "they are redirected back to their profile" do 
        expect(page).to have_current_path(user_profile_path(@bob))
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully made a post")
      end

      scenario "they see the posted text" do 
        expect(page).to have_content("this is my first post")
      end

    end

    context "with image only" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "bob"

        create_post_with_picture_only("#{Rails.root}/spec/files/empire_state_building.jpg")
      end

      scenario "they are redirected back to their profile" do 
        expect(page).to have_current_path(user_profile_path(@bob))
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully made a post")
      end

      scenario "they see the posted image" do 
        expect(page).to have_image("empire_state_building.jpg")
      end

    end

    context "with text and an image" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "bob"

        create_post_with_text_and_picture("this is my first post", "#{Rails.root}/spec/files/empire_state_building.jpg")
      end

      scenario "they are redirected back to their profile" do 
        expect(page).to have_current_path(user_profile_path(@bob))
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully made a post")
      end

      scenario "they see the posted text" do 
        expect(page).to have_content("this is my first post")
      end

      scenario "they see the posted image" do 
        expect(page).to have_image("empire_state_building.jpg")
      end

    end

    context "without text or image" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "bob"
        fill_in "Body", with: ""
        click_on "Create Post"
      end

      scenario "they see an error message" do 
        expect(page).to have_content("must have text or picture")
      end

    end

    context "with a non-image file" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "bob"

        create_post_with_picture_only("#{Rails.root}/spec/files/test.txt")
      end

      scenario "they see an error message" do 
        expect(page).to have_content("not a valid file format")
      end

    end

  end

  context "from the timeline" do 

    context "with text only" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "timeline"
        fill_in "Body", with: "this is my first post"
        click_on "Create Post"
      end

      scenario "they are redirected back to the timeline" do 
        expect(page).to have_current_path(posts_path)
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully made a post")
      end

      scenario "they see the posted text" do 
        expect(page).to have_content("this is my first post")
      end

    end

    context "with image only" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "timeline"

        create_post_with_picture_only("#{Rails.root}/spec/files/empire_state_building.jpg")
      end

      scenario "they are redirected back to the timeline" do 
        expect(page).to have_current_path(posts_path)
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully made a post")
      end

      scenario "they see the posted image" do 
        expect(page).to have_image("empire_state_building.jpg")
      end

    end

    context "with text and an image" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "timeline"

        create_post_with_text_and_picture("this is my first post", "#{Rails.root}/spec/files/empire_state_building.jpg")
      end

      scenario "they are redirected back to the timeline" do 
        expect(page).to have_current_path(posts_path)
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully made a post")
      end

      scenario "they see the posted text" do 
        expect(page).to have_content("this is my first post")
      end

      scenario "they see the posted image" do 
        expect(page).to have_image("empire_state_building.jpg")
      end

    end

    context "without text or an image" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "timeline"
        fill_in "Body", with: ""
        click_on "Create Post"
      end

      scenario "they see an error message" do 
        expect(page).to have_content("must have text or picture")
      end

    end

    context "with a non-image file" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        sign_in @bob

        visit root_path
        click_on "timeline"

        create_post_with_picture_only("#{Rails.root}/spec/files/test.txt")
      end

      scenario "they see an error message" do 
        expect(page).to have_content("not a valid file format")
      end

    end

  end

end