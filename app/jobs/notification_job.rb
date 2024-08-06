class NotificationJob < ApplicationJob
  queue_as :default

  def perform(notification)
    notification.recipient.increment!(:unread)
#    ActionCable.server.broadcast "notification_#{notification.user.id}", 
    ActionCable.server.broadcast "notification_#{notification.recipient_id}", 
      message: render_notification(notification), 
      unread: notification.recipient.unread
#    NotificationMailer.notification_to_recipient(notification).deliver_now
#    NotificationMailer.notification_to_recipient(notification).deliver_later
  end

  private

    def render_notification(notification)
      ApplicationController.render(partial: 'notifications/notification', locals: { notification: notification})
    end
end  