class FriendshipsController < ApplicationController
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
end