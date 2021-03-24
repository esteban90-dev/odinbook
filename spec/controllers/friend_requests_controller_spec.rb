require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do 

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
        post :create, params: { friend_request: { requestor_id: 1, requestee_id: 2 } }
        
        expect(response).to redirect_to new_user_session_path
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

  end

  describe "#ignore" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        delete :ignore, params: { id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

end