class NotificationsChannel < ApplicationCable::Channel
  def subscribed
#    stream_from "notification_#{current_user.id}"
    stream_from "notification_#{params[:noti_id]}"
  end
end