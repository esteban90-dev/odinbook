require 'rails_helper'

RSpec.describe LikesController, type: :controller do 

  describe "#create" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        post :create, params: { post_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 
      before(:each) do 
        #a user can't create likes on posts that belong to users that they aren't friends with
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        post_1 = bob.posts.create(body: "this is a post")

        sign_in frank
        post :create, params: { post_id: post_1.id, redirect: "profile"}
      end

      it "doesn't create the like" do 
        expect(Like.all.count).to eq(0)
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
      end
    end

    context "as a user trying to like a post twice" do 

      before(:each) do 
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        @post_1 = bob.posts.create(body: "this is a post")
        @post_1.likes.create(liker: bob)

        sign_in bob
        post :create, params: { post_id: @post_1.id, redirect: "profile"}
      end

      it "doesn't create a second like" do 
        expect(@post_1.likes.count).to eq(1)
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
      end

    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        post_1 = @bob.posts.create(body: "this is a post")

        sign_in @bob
        post :create, params: { post_id: post_1.id, redirect: "profile"}
      end

      it "redirects to the new profile page" do 
        expect(response).to redirect_to new_user_profile_path(@bob)
      end

      it "displays an alert" do 
        expect(flash[:alert]).to eq("you must complete your profile before continuing")
      end
    end

  end

  describe "#destroy" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        delete :destroy, params: { id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 
      before(:each) do 
        #a user can't destroy (unlike) someone else's like
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        post = bob.posts.create(body: "this is a post")
        like = post.likes.create(liker: bob)
        
        sign_in frank
        delete :destroy, params: { id: like.id, redirect: "profile" }
      end

      it "doesn't destroy the like" do 
        expect(Like.all.count).to eq(1)
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        post = @bob.posts.create(body: "this is a post")
        like = post.likes.create(liker: @bob)

        sign_in @bob
        delete :destroy, params: { id: like.id, redirect: "profile" }
      end

      it "redirects to the new profile page" do 
        expect(response).to redirect_to new_user_profile_path(@bob)
      end

      it "displays an alert" do 
        expect(flash[:alert]).to eq("you must complete your profile before continuing")
      end
    end

  end

end