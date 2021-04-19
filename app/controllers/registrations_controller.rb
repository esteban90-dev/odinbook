class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    if resource.provider
      resource.update_without_password(params)
    else
      super
    end
  end

  def after_sign_up_path_for(resource)
    current_user.notifications.create(message: "Welcome to Odinbook!")
    edit_user_profile_path(resource.id)
  end
end