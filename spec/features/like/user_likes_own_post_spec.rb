require 'rails_helper'

feature "user likes his/her own post" do 

  scenario "no new notification is generated" do 
    @bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
    @post = @bob.posts.create(body: "this is a post")
    sign_in @bob

    visit root_path
    find(nav_section).click_on "bob"
    like(@post)
    click_on "notifications" 
    
    expect(notifications_on_page.count).to eq(0)
  end

end