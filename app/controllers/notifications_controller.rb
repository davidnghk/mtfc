class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
  	current_user.unread = 0
    current_user.save
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    if current_user.admin?
      @notifications = Notification.order("created_at DESC").page(params[:notification]).per(10)
    else
      @notifications = Notification.where(recipient: current_user).order("created_at DESC").page(params[:notification]).per(10)
    end
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    reader json: {success: true}
  end
end
