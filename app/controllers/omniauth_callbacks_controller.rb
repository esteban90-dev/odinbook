class OmniauthCallbacksController < Devise::OmniauthCallbacksController 
  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.new_record?
      if user.save
        user.notifications.create(message: "Welcome to Odinbook!")
      end
    end 

    if user.persisted?
      sign_in user
      flash[:notice] = "Signed in successfully"
      redirect_to edit_user_profile_path(user.id)
    else 
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_path
    end
  end
end