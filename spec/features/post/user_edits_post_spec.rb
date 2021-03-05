require 'rails_helper'

feature "user edits a post" do 

  context "with new text" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
      sign_in @bob

      visit root_path
      click_on "bob"
      
      edit_post_text(@bob.posts.last, "chicken is better than pork")
    end

    scenario "they see the modified post" do 
      user_sees_post_text_edit(@bob.posts.last, "chicken is better than pork")
    end

    scenario "they see a flash message" do 
      expect(page).to have_content("Successfully updated post")
    end

  end

end