require 'rails_helper' 

RSpec.describe ProfilesController, type: :controller do 

  describe "#show" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :show, params: { user_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        
        sign_in @bob
        get :show, params: { user_id: 1 }
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
        get :edit, params: { user_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        
        sign_in @bob
        get :edit, params: { user_id: 1 }
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
        patch :update, params: { user_id: 1, profile: { location: "New York", education: "high school", relationship_status: "single" } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as a user that hasn't completed their profile" do 
      before(:each) do 
        @bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
        
        sign_in @bob
        patch :update, params: { user_id: 1, profile: { location: "New York", education: "high school", relationship_status: "single" } }
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