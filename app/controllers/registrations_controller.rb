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
    resource.notifications.create(message: "Welcome to Odinbook!  #{view_context.link_to("Click here", edit_user_profile_path(resource.id))} to edit your profile.")
    super
  end
end