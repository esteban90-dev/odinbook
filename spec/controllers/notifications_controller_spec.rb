require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do 

  describe "#index" do 

    context "as an unauthenticated user" do 
      it "redirects to the sign in page" do 
        get :index, params: { user_id: 1 }
        
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

end