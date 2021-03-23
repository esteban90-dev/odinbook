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

  end

  describe "#update" do 

    context "as an unauthenticated user" do 

      it "redirects to the sign in page" do 
        patch :update, params: { id: 1 }
        
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

  end

end