require 'rails_helper'

feature "user sees new notifications" do 

  before(:each) do 
    user = FactoryBot.create(:user)
    @notification_1 = user.notifications.create(message: "hello there!")
    @notification_2 = user.notifications.create(message: "goodbye!")

    sign_in user
    visit root_path
  end

  scenario "the 'notifications' link is bold" do
    expect(page).to have_css('b', text: 'notifications')
  end

  scenario "the notifications are in descending order" do 
    click_on "notifications" 

    expect(page.body.index(@notification_2.message) < page.body.index(@notification_1.message)).to eq(true)
  end

  scenario "once viewed, the 'notifications' link is no longer bold" do 
    click_on "notifications" 
    visit root_path

    expect(page).not_to have_css('b', text: 'notifications')
  end

end