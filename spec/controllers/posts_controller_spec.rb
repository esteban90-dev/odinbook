require 'rails_helper'

RSpec.describe PostsController, type: :controller do 

  describe "#index" do 

    context "as an unauthenticated user" do 

      it "redirects to the sign in page" do 
        get :index
        
        expect(response).to redirect_to new_user_session_path
      end

    end

  end

  describe "#create" do 

    context "as an unauthenticated user" do 

      it "redirects to the sign in page" do 
        post :create, params: { user_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
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
        get :edit, params: { id: post.id }
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
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
        post.body = "this is another post"
        updated_post_params = post.attributes.merge("redirect" => "profile") 

        sign_in frank
        patch :update, params: { id: post.id, post: updated_post_params }
      end

      it "doesn't update the record" do 
        expect(Post.first.body).to eq("this is a post")
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
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
        bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        @post = bob.posts.create(body: "this is a post")
        
        sign_in frank
        delete :destroy, params: { id: @post.id, post: { redirect: "profile" } }
      end

      it "doesn't destroy the record" do 
        expect(Post.all.count).to eq(1)
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
      end

    end

  end

end