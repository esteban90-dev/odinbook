require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do 

  describe "#index" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :index, params: { user_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
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

end