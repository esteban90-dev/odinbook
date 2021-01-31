class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    
    flash[:notice] = "Successfully unfriended #{@friendship.friend.name}"
    redirect_to friendships_path
  end
end