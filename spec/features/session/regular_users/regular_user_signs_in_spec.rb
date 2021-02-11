require "rails_helper"

feature "regular user signs in" do 

  context "successfully" do 

    before(:each) do 
      @user = FactoryBot.create(:user)

      visit root_path
      click_on "sign in"
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Sign in"
    end
    
    scenario "they see a flash message" do 
      expect(page).to have_content("Signed in successfully")
    end

    scenario "they see that they are signed in" do 
      expect(page).to have_content("signed in as #{@user.name}")
    end

  end

  context "unsuccessfully" do

    scenario "they see an error message" do 
      user = FactoryBot.create(:user)
      
      visit root_path
      click_on "sign in"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password + "asdf"
      click_on "Sign in"

      expect(page).to have_content("Invalid Email or password")
    end

  end

end