require "rails_helper"

feature "user sees list of other users" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    @frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    @john = FactoryBot.create(:user, name: "john", email: "john@mail.com")

    sign_in @bob
    visit root_path
    click_on "users"
  end

  scenario "user does not see themselves in the list" do 
    expect(page).not_to have_css("##{@bob.id}", text: "bob")
  end

  scenario "user sees other users in the list" do   
    expect(page).to have_css("[data-test=user-#{@frank.id}]", text: @frank.name)
    expect(page).to have_css("[data-test=user-#{@john.id}]", text: @john.name)
  end

end