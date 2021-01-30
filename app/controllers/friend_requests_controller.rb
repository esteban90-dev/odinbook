class FriendRequestsController < ApplicationController
  def index
    @incoming_friend_requests = current_user.incoming_friend_requests
  end

  def create
    request = FriendRequest.new(request_params)

    if request.save
      flash[:notice] = "Friend request successfully sent to #{request.requestee.name}"
      redirect_to users_path
    end
  end

  def destroy
    request = current_user.incoming_friend_requests.find(params[:id])
    
    if params[:accept] == "true"
      current_user.friendships.create(friend_id: request.requestor.id)
      flash[:notice] = "Successfully accepted friend request from #{request.requestor.name}"
    else
      flash[:notice] = "Successfully ignored friend request from #{request.requestor.name}"
    end
    
    request.destroy
    redirect_to friendships_path
  end

  private

  def request_params
    params.require(:friend_request).permit(:requestor_id, :requestee_id)
  end
end