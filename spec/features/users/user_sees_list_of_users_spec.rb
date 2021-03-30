require "rails_helper"

feature "user sees list of other users" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@mail.com")
    @frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@mail.com")
    @john = FactoryBot.create(:user, :with_profile, name: "john", email: "john@mail.com")

    sign_in @bob
    visit root_path
    click_on "users"
  end

  scenario "user does not see themselves in the list" do 
    expect(page).not_to have_user(@bob)
  end

  scenario "user sees other users in the list" do   
    expect(page).to have_user(@frank)
    expect(page).to have_user(@john)
  end

end