class NotificationsController < ApplicationController
  before_action :check_profile_completion

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @notifications.each{ |notification| notification.touch if notification.unacked? }
  end
end