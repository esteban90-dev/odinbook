class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def edit
    @user = current_user
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if @profile.update(profile_params)
      flash[:notice] = "Successfully updated profile"
      redirect_to user_profile_path(params[:user_id])
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :education, :relationship_status, :picture)
  end
end