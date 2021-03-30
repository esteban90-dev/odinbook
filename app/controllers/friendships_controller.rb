class FriendshipsController < ApplicationController
  before_action :authorize_index, only: :index
  before_action :authorize_destroy, only: :destroy
  before_action :check_profile_completion

  def index
    user = User.find(params[:user_id])
    if current_user.friends.include?(user) || current_user == user
      @friendships = user.friendships
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    
    flash[:notice] = "Successfully unfriended #{@friendship.friend.name}"
    redirect_to user_friendships_path(current_user.id)
  end

  private

  def authorize_index
    #only allow current user to see his/her friends or his/her friends' friends
    user = User.find(params[:user_id])
    unless user == current_user || current_user.friends.include?(user)
      unauthorized
    end
  end

  def authorize_destroy
    #only the user or friend can destroy the record
    if Friendship.find(params[:id]).user != current_user && Friendship.find(params[:id]).friend != current_user 
      unauthorized
    end
  end
end