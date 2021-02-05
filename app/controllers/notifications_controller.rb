class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @notifications.each{ |notification| notification.touch if notification.unacked? }
  end
end