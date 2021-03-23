class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @notifications.each{ |notification| notification.touch if notification.unacked? }
  end
end