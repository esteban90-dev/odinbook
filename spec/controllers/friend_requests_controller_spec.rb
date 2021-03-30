require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do 

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
        post :create, params: { friend_request: { requestor_id: 1, requestee_id: 2 } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user trying to send a duplicate friend request" do 
      before(:each) do 
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        bob.sent_friend_requests.create(requestee: frank)

        sign_in bob
        post :create, params: { friend_request: { requestor_id: bob.id, requestee_id: frank.id } }
      end

      it "doesn't create a second friend request" do 
        expect(FriendRequest.all.count).to eq(1)
      end

      it "redirects to the posts index" do 
        expect(response).to redirect_to posts_path
      end

      it "sets a flash alert message" do 
        expect(flash[:alert]).to eq("this action is not permitted")
      end
    end

    context "as a user trying to send a friend request to someone they are already friends with" do 
      before(:each) do 
        bob = FactoryBot.create(:user, :with_profile, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        bob.friends << frank

        sign_in bob
        post :create, params: { friend_request: { requestor_id: bob.id, requestee_id: frank.id } }
      end

      it "doesn't create a friend request" do 
        expect(FriendRequest.all.count).to eq(0)
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

        sign_in @bob
        post :create, params: { friend_request: { requestor_id: @bob.id, requestee_id: frank.id } }
      end

      it "redirects to the new profile page" do 
        expect(response).to redirect_to new_user_profile_path(@bob)
      end

      it "displays an alert" do 
        expect(flash[:alert]).to eq("you must complete your profile before continuing")
      end
    end

  end

  describe "#accept" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        delete :accept, params: { id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        friend_request = frank.sent_friend_requests.create(requestee: @bob)

        sign_in @bob
        delete :accept, params: { id: friend_request.id }
      end

      it "redirects to the new profile page" do 
        expect(response).to redirect_to new_user_profile_path(@bob)
      end

      it "displays an alert" do 
        expect(flash[:alert]).to eq("you must complete your profile before continuing")
      end
    end

  end

  describe "#ignore" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        delete :ignore, params: { id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        frank = FactoryBot.create(:user, :with_profile, name: "frank", email: "frank@example.com")
        friend_request = frank.sent_friend_requests.create(requestee: @bob)

        sign_in @bob
        delete :ignore, params: { id: friend_request.id }
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