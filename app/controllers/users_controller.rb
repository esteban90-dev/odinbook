class UsersController < ApplicationController
  before_action :check_profile_completion
  
  def index
    @users = User.where.not(id: current_user.id)
  end
end