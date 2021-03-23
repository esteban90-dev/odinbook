require 'rails_helper'

RSpec.describe LikesController, type: :controller do 

  describe "#create" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        post :create, params: { post_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
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
        post = bob.posts.create(body: "this is a post")
        like = post.likes.create(liker: bob)
        
        sign_in frank
        delete :destroy, params: { id: like.id, redirect: "profile" }
      end

      it "doesn't destroy the record" do 
        expect(Like.all.count).to eq(1)
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