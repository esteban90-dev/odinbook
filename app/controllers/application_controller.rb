class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def unauthorized
    flash[:alert] = "this action is not permitted"
    redirect_to posts_path
  end

  def check_profile_completion
    if current_user.profile.nil?
      flash[:alert] = "you must complete your profile before continuing"
      redirect_to new_user_profile_path(current_user)
    end
  end
end
