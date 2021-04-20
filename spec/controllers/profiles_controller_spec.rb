require 'rails_helper' 

RSpec.describe ProfilesController, type: :controller do 

  describe "#show" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :show, params: { user_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
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

  end

  describe "#update" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        patch :update, params: { user_id: 1, profile: { location: "New York", education: "high school", relationship_status: "single" } }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

end