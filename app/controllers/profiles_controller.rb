class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :check_profile_completion, except: [:new, :create]
  before_action :resize_picture, only: [:create, :update]

  def show
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      UserMailer.with(user: current_user).welcome_email.deliver_now
      flash[:notice] = "Successfully created profile"
      current_user.notifications.create(message: "Welcome to Odinbook!")
      redirect_to user_profile_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "Successfully updated profile"
      redirect_to user_profile_path(current_user)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :education, :relationship_status, :picture)
  end

  def set_profile
    @profile = current_user.profile
  end

  def resize_picture
    if profile_params[:picture]
      path = profile_params[:picture].tempfile.path
      ImageProcessing::MiniMagick.source(path)
          .resize_to_limit(250,250)
          .call(destination: path)
    end
  end
end