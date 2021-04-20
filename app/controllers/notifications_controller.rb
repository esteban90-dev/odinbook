class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.unacked.order(created_at: :desc)
    @notifications.each{ |notification| notification.touch }
  end
end