require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do 

  describe "#index" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :index, params: { user_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as an unauthorized user" do 
      before(:each) do 
        #user can't see the friends of someone they aren't friends with
        bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        john = FactoryBot.create(:user, name: "john", email: "john@example.com")
        bob.friends << frank

        sign_in john
        get :index, params: { user_id: bob.id }
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

        sign_in @bob
        get :index, params: { user_id: @bob.id }
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
        #only one of the users in a friendship can destroy (unfriend) the friendship
        bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, name: "frank", email: "frank@example.com")
        john = FactoryBot.create(:user, name: "john", email: "john@example.com")
        friendship = Friendship.create(user: bob, friend: frank)

        sign_in john
        delete :destroy, params: { id: friendship.id }
      end

      it "doesn't destroy the friendship" do 
        #there are two records for each friendship (one is a reverse friendship)
        expect(Friendship.all.count).to eq(2) 
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
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        friendship = Friendship.create(user: @bob, friend: frank)

        sign_in @bob
        delete :destroy, params: { id: friendship.id }
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