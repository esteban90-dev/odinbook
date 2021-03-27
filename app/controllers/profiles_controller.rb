class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def show
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      flash[:notice] = "Successfully created profile"
      current_user.notifications.create(message: "Welcome to Odinbook!")
      redirect_to user_profile_path(current_user)
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "Successfully updated profile"
      redirect_to user_profile_path(params[:user_id])
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :education, :relationship_status, :picture)
  end

  def set_profile
    @profile = current_user.profile
  end
end