class OmniauthCallbacksController < Devise::OmniauthCallbacksController 
  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])

    if !user.persisted?
      if user.save
        sign_in user
        flash[:notice] = "Signed in successfully"
        redirect_to new_user_profile_path(user)
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_path
      end
    else
      sign_in user
      flash[:notice] = "Signed in successfully"
      redirect_to user_profile_path(user)
    end
      
  end
end