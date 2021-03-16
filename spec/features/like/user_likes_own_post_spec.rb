require 'rails_helper'

feature "user likes his/her own post" do 

  scenario "no new notification is generated" do 
    @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    @post = @bob.posts.create(body: "this is a post")
    sign_in @bob

    visit root_path
    click_on "bob"
    find("[data-test=post-#{@post.id}]").click_on "like"
  
    expect(@bob.notifications.unacked.any?).to eq(false)
  end

end