class FriendRequestsController < ApplicationController
  before_action :find_request, only: [:accept, :ignore]

  def index
    @incoming_friend_requests = current_user.incoming_friend_requests
    @sent_friend_requests = current_user.sent_friend_requests
  end

  def create
    request = current_user.sent_friend_requests.new(request_params)

    if !current_user.friends.include?(request.requestee) && request.save
      flash[:notice] = "Friend request successfully sent"
      request.requestee.notifications.create(message: "You have a new friend request from #{request.requestor.name}" + accept_ignore_links(request))
      redirect_to users_path
    else
      unauthorized
    end
  end

  def accept
    friendship = current_user.friendships.new(friend_id: @request.requestor.id)

    if friendship.save
      @request.destroy

      flash[:notice] = "You and #{@request.requestor.name} are now friends"
      @request.requestor.notifications.create(message: "#{requestee_profile_link(@request.requestee)} accepted your friend request")
      redirect_to user_friendships_path(current_user.id)
    end
  end

  def ignore
    @request.destroy

    flash[:notice] = "Successfully ignored friend request"
    redirect_to user_friendships_path(current_user.id)
  end

  private

  def request_params
    params.require(:friend_request).permit(:requestee_id)
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