require 'rails_helper'

feature "user edits a post" do 

  context "and changes the text" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @post = @bob.posts.create(body: "this is a post")
      sign_in @bob

      visit root_path
      click_on "bob"

      find("[data-test=post-#{@post.id}]").click_on "edit"
      fill_in "Body", with: "this is different"
      click_on "Update Post"
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

  context "and changes the picture" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      post_image_file = fixture_file_upload(Rails.root.join('spec','files','empire_state_building.jpg'), 'image/jpg')
      @post = @bob.posts.create(body: "this is the second post", picture: post_image_file)
      sign_in @bob

      visit root_path
      click_on "bob"

      find("[data-test=post-#{@post.id}]").click_on "edit"
      attach_file "Picture", "#{Rails.root}/spec/files/white_house.jpg"
      click_on "Update Post"
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