class FriendRequestsController < ApplicationController
  def create
    request = FriendRequest.new(request_params)

    if request.save
      flash[:notice] = "Friend request successfully sent to #{request.requestee.name}"
      redirect_to users_path
    end
  end

  private

  def request_params
    params.require(:friend_request).permit(:requestor_id, :requestee_id)
  end
end