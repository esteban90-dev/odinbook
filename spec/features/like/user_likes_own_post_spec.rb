require 'rails_helper'

feature "user likes his/her own post" do 

  scenario "no new notification is generated" do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    sign_in @bob

    visit root_path
    click_on "bob"
    @post = @bob.posts.last
    like(@post)
  
    expect(@bob.notifications.unacked.any?).to eq(false)
  end

end