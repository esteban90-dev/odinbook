class OmniauthCallbacksController < Devise::OmniauthCallbacksController 
  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in user
      redirect_to root_path
    end
  end
end