require 'rails_helper'

feature "user likes his/her own post" do 

  context "from their profile" do 

    scenario "no new notification is generated" do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @post = @bob.posts.create(body: "this is a post")
      sign_in @bob

      visit root_path
      click_on "bob"
      like(@post)
      click_on "notifications"
    
      expect(notifications_on_page.count).to eq(0)
    end

  end

  context "from the timeline" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @post = @bob.posts.create(body: "this is a post")
      sign_in @bob

      visit root_path
      click_on "timeline"
      like(@post)
    end

    scenario "they are redirected back to the timeline" do 
      expect(page).to have_current_path(posts_path)
    end

    scenario "no new notification is generated" do 
      click_on "notifications" 
      
      expect(notifications_on_page.count).to eq(0)
    end

  end

end