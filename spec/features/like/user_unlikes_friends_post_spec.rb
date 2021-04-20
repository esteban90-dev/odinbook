require 'rails_helper'

feature "user unlikes a friend's post" do 

  context "from the friend's profile" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
      @frank.friends << @bob
      @post = @bob.posts.create(body: "this is a post")
      @post.likes.create(liker: @frank)
      sign_in @frank

      visit root_path
      click_on "frank"
      click_on "friends"
      click_on "bob"
      
      unlike(@post)
    end

    scenario "they are redirected back to the friend's profile" do 
      expect(page).to have_current_path(user_profile_path(@bob))
    end

    scenario "the user sees the like count decrement" do 
      expect(page).to have_post_with_likes(@post, 0)
    end

    scenario "the user doesn't see the 'unlike' button anymore" do 
      user_doesnt_see_post_unlike_button(@post)
    end

    scenario "the user now sees the like button" do 
      user_sees_post_like_button(@post)
    end

  end

  context "from the timeline" do 

    before(:each) do 
      @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
      @frank.friends << @bob
      @post = @bob.posts.create(body: "this is a post")
      @post.likes.create(liker: @frank)
      sign_in @frank

      visit root_path
      click_on "timeline"
      
      unlike(@post)
    end

    scenario "they are redirected back to the timeline" do 
      expect(page).to have_current_path(posts_path)
    end

    scenario "the user sees the like count decrement" do 
      expect(page).to have_post_with_likes(@post, 0)
    end

    scenario "the user doesn't see the 'unlike' button anymore" do 
      user_doesnt_see_post_unlike_button(@post)
    end

    scenario "the user now sees the like button" do 
      user_sees_post_like_button(@post)
    end

  end

end