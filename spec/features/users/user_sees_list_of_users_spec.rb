require "rails_helper"

feature "user sees list of other users" do 

  scenario "successfully" do 

    bob = FactoryBot.create(:user, name: "bob", email: "bob@mail.com")
    frank = FactoryBot.create(:user, name: "frank", email: "frank@mail.com")
    john = FactoryBot.create(:user, name: "john", email: "john@mail.com")

    sign_in bob
    visit users_path

    expect(page).not_to have_user(bob)
    expect(page).to have_user(frank)
    expect(page).to have_user(john)
  end

end