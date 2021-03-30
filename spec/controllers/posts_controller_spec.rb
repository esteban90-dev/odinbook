require 'rails_helper'

RSpec.describe PostsController, type: :controller do 

  describe "#index" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :index
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        
        sign_in @bob
        get :index
      end

      it "redirects to the new profile page" do 
        expect(response).to redirect_to new_user_profile_path(@bob)
      end

      it "displays an alert" do 
        expect(flash[:alert]).to eq("you must complete your profile before continuing")
      end
    end

  end

  describe "#create" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        post :create, params: { user_id: 1, post: { body: "this is a post" } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        
        sign_in @bob
        post :create, params: { user_id: 1, post: { body: "this is a post" } }
      end

      it "redirects to the new profile page" do 
        expect(response).to redirect_to new_user_profile_path(@bob)
      end

      it "displays an alert" do 
        expect(flash[:alert]).to eq("you must complete your profile before continuing")
      end
    end

  end

  describe "#edit" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :edit, params: { id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 

      before(:each) do 
        bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        post = bob.posts.create(body: "this is a post")

        sign_in frank
        get :edit, params: { id: post.id, post: { redirect: "profile" } }
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

        sign_in @bob
        get :edit, params: { id: post.id, post: { redirect: "profile" } }
      end

      it "redirects to the new profile page" do 
        expect(response).to redirect_to new_user_profile_path(@bob)
      end

      it "displays an alert" do 
        expect(flash[:alert]).to eq("you must complete your profile before continuing")
      end
    end

  end

  describe "#update" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        patch :update, params: { id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 

      before(:each) do 
        bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        post = bob.posts.create(body: "this is a post")

        sign_in frank
        patch :update, params: { id: post.id, post: { body: "this is my post", redirect: "profile" } }
      end

      it "doesn't update the post" do 
        expect(Post.first.body).to eq("this is a post")
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
        
        sign_in @bob
        patch :update, params: { id: post.id, post: { body: "this is my post", redirect: "profile" } }
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
        bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        post = bob.posts.create(body: "this is a post")

        delete :destroy, params: { id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 

      before(:each) do 
        bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        @post = bob.posts.create(body: "this is a post")
        
        sign_in frank
        delete :destroy, params: { id: @post.id, post: { redirect: "profile" } }
      end

      it "doesn't destroy the post" do 
        expect(Post.all.count).to eq(1)
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
        
        sign_in @bob
        delete :destroy, params: { id: post.id, post: { redirect: "profile" } }
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