require 'rails_helper'

RSpec.describe CommentsController, type: :controller do 

  describe "#create" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        post :create, params: { post_id: 1, comment: { body: "this is a comment", redirect: "profile" } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 
      before(:each) do 
        #users can't comment on posts that don't belong to them or their friends
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        post_1 = bob.posts.create(body: "this is a post")

        sign_in frank
        post :create, params: { post_id: post_1.id, comment: { body: "this is a comment", redirect: "profile" } }
      end

      it "doesn't create a new comment" do 
        expect(Comment.all.count).to eq(0)
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
      end
    end

  end

  describe "#edit" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :edit, params: { id: 1, comment: { redirect: "profile" } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 
      before(:each) do 
        #users can't edit comments that don't belong to them 
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        post_1 = bob.posts.create(body: "this is a post")
        comment_1 = post_1.comments.create(body: "this is a comment", commenter: bob)

        sign_in frank
        get :edit, params: { id: comment_1.id, comment: { redirect: "profile" } }
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
        patch :update, params: { id: 1, comment: { body: "new comment text", redirect: "profile" } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 
      before(:each) do 
        #users can't update comments that don't belong to them 
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        @post_1 = bob.posts.create(body: "this is a post")
        @comment_1 = @post_1.comments.create(body: "this is a comment", commenter: bob)

        sign_in frank
        patch :update, params: { id: @comment_1.id, comment: { body: "new comment text", redirect: "profile" } }
      end

      it "doesn't update the comment" do 
        @comment_1.reload

        expect(@comment_1.body).to eq("this is a comment")
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
        delete :destroy, params: { id: 1, comment: { redirect: "profile" } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 
      before(:each) do 
        #users can't delete comments that don't belong to them 
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        @post_1 = bob.posts.create(body: "this is a post")
        @comment_1 = @post_1.comments.create(body: "this is a comment", commenter: bob)

        sign_in frank
        delete :destroy, params: { id: @comment_1.id, comment: { redirect: "profile" } }
      end

      it "doesn't delete the comment" do 
        expect(Comment.all.count).to eq(1)
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