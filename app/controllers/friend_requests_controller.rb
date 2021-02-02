class FriendRequestsController < ApplicationController
  before_action :find_request, only: [:accept, :ignore]

  def index
    @incoming_friend_requests = current_user.incoming_friend_requests
    @sent_friend_requests = current_user.sent_friend_requests
  end

  def create
    request = FriendRequest.new(request_params)

    if request.save
      flash[:notice] = "Friend request successfully sent to #{request.requestee.name}"
      redirect_to users_path
    end
  end

  def accept
    current_user.friendships.create(friend_id: @request.requestor.id)
    @request.destroy

    flash[:notice] = "Successfully accepted friend request from #{@request.requestor.name}"
    redirect_to friendships_path
  end

  def ignore
    @request.destroy

    flash[:notice] = "Successfully ignored friend request from #{@request.requestor.name}"
    redirect_to friendships_path
  end

  private

  def request_params
    params.require(:friend_request).permit(:requestor_id, :requestee_id)
  end

  def find_request 
    @request = current_user.incoming_friend_requests.find(params[:id])
  end
end