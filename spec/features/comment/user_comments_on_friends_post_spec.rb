require 'rails_helper'

feature "user comments on friend's post" do 

  context "from the friend's profile" do 

    context "with text" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        @bob.friends << @frank
        @post = @bob.posts.create(body: "this is a post")

        sign_in @frank

        visit root_path
        click_on "frank"
        click_on "friends"
        click_on "bob"

        comment_on_post(@post, "this post is great")
      end

      scenario "they are redirected back to the friend's profile" do 
        expect(page).to have_current_path(user_profile_path(@bob))
      end

      scenario "they see the comment" do
        expect(page).to have_content("this post is great")
      end

      scenario "they see their name appear next to the comment" do 
        expect(page).to have_commenter_name(@post.comments.first, "frank")
      end

      scenario "they click their name next to the comment and it leads them back to their profile" do 
        click_on_comment_user_name(@post.comments.first)

        expect(page).to have_current_path(user_profile_path(@frank.id))
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully created comment")
      end

      scenario "the post's author receives a notification" do 
        sign_out @frank
        sign_in @bob

        visit root_path
        click_on "notifications"

        expect(page).to have_content("frank commented on your post")
      end

      scenario "the post's author clicks the link in the notification and it leads them back to their profile" do 
        sign_out @frank
        sign_in @bob

        visit root_path
        click_on "notifications"
        click_on "post"

        expect(page).to have_current_path(user_profile_path(@bob.id))
      end

      scenario "the post's author doesn't see an edit link next to the comment" do 
        sign_out @frank
        sign_in @bob

        visit root_path
        click_on "bob"

        comment_doesnt_appear_editable(@post.comments.first)
      end

      scenario "the post's author doesn't see a delete link next to the comment" do 
        sign_out @frank
        sign_in @bob
        
        visit root_path
        click_on "bob"

        comment_doesnt_appear_deletable(@post.comments.first)
      end

    end

    context "without text" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        @bob.friends << @frank
        @post = @bob.posts.create(body: "this is a post")

        sign_in @frank

        visit root_path
        click_on "frank"
        click_on "friends"
        click_on "bob"

        comment_on_post(@post, "")
      end

      scenario "they see an error message" do 
        expect(page).to have_content("can't be blank")
      end

    end

  end

  context "from the timeline" do 

    context "with text" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        @bob.friends << @frank
        @post = @bob.posts.create(body: "this is a post")

        sign_in @frank

        visit root_path
        click_on "timeline"

        comment_on_post(@post, "this post is great")
      end

      scenario "they are redirected back to the timeline" do 
        expect(page).to have_current_path(posts_path)
      end

      scenario "they see the comment" do
        expect(page).to have_content("this post is great")
      end

      scenario "they see their name appear next to the comment" do 
        expect(page).to have_commenter_name(@post.comments.first, "frank")
      end

      scenario "they click their name next to the comment and it leads them back to their profile" do 
        click_on_comment_user_name(@post.comments.first)

        expect(page).to have_current_path(user_profile_path(@frank.id))
      end

      scenario "they see a flash message" do 
        expect(page).to have_content("Successfully created comment")
      end

      scenario "the post's author receives a notification" do 
        sign_out @frank
        sign_in @bob

        visit root_path
        click_on "notifications"

        expect(page).to have_content("frank commented on your post")
      end

      scenario "the post's author clicks the link in the notification and it leads them back to their profile" do 
        sign_out @frank
        sign_in @bob

        visit root_path
        click_on "notifications"
        click_on "post"

        expect(page).to have_current_path(user_profile_path(@bob.id))
      end

      scenario "the post's author doesn't see an edit link next to the comment" do 
        sign_out @frank
        sign_in @bob

        visit root_path
        click_on "timeline"

        comment_doesnt_appear_editable(@post.comments.first)
      end

      scenario "the post's author doesn't see a delete link next to the comment" do 
        sign_out @frank
        sign_in @bob

        visit root_path
        click_on "timeline"

        comment_doesnt_appear_deletable(@post.comments.first)
      end

    end

    context "without text" do 

      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        @frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        @bob.friends << @frank
        @post = @bob.posts.create(body: "this is a post")

        sign_in @frank

        visit root_path
        click_on "timeline"

        comment_on_post(@post, "")
      end

      scenario "they see an error message" do 
        expect(page).to have_content("can't be blank")
      end

    end

  end

end