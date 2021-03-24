class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_request, only: [:accept, :ignore]

  def index
    @incoming_friend_requests = current_user.incoming_friend_requests
    @sent_friend_requests = current_user.sent_friend_requests
  end

  def create
    request = FriendRequest.new(request_params)

    if request.save
      flash[:notice] = "Friend request successfully sent"
      request.requestee.notifications.create(message: "You have a new friend request from #{request.requestor.name}" + accept_ignore_links(request))
      redirect_to users_path
    end
  end

  def accept
    current_user.friendships.create(friend_id: @request.requestor.id)
    @request.destroy

    flash[:notice] = "You and #{@request.requestor.name} are now friends"
    @request.requestor.notifications.create(message: "#{requestee_profile_link(@request.requestee)} accepted your friend request")
    redirect_to user_friendships_path(current_user.id)
  end

  def ignore
    @request.destroy

    flash[:notice] = "Successfully ignored friend request"
    redirect_to user_friendships_path(current_user.id)
  end

  private

  def request_params
    params.require(:friend_request).permit(:requestor_id, :requestee_id)
  end

  def find_request 
    @request = current_user.incoming_friend_requests.find(params[:id])
  end

  def accept_ignore_links(request)
    " #{view_context.link_to("accept", accept_friend_request_path(request.id), method: :delete )}" +
    " #{view_context.link_to("ignore", ignore_friend_request_path(request.id), method: :delete )}"
  end

  def requestee_profile_link(requestee)
    "#{view_context.link_to("#{requestee.name}", user_profile_path(requestee.id) )}"
  end
end