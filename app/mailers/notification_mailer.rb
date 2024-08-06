class NotificationMailer < ApplicationMailer

  def notification_to_recipient(notification)
    @notification = notification
    mail(to: @notification.recipient.email, subject: @notification.user.name + ' Notification 通告: ' +  @notification.no.to_s  )
  end
    
end
