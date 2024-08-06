class Call < ApplicationRecord

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  belongs_to :user

  after_create :create_notification

  private

  def create_notification
  	self.user.guardians.each do |guardian|
  		if guardian.guardian_user_id?
		    Notification.create(recipient_id: guardian.guardian_user_id, user: self.user,
            notifiable: self, 
      			content: "#{Time.now.to_formatted_s(:db)}  #{self.user.name} calls #{guardian.name} for HELP! ")
  		end

#      if guardian.phone?
#        account_sid = 'AC40b2549c5c1849cd8eabd349dde9c0ba'
#        auth_token = 'f2ed640dcd9897768b4bcf43989e3904'
#        @client = Twilio::REST::Client.new(account_sid, auth_token)
#        @client.messages.create(
#          from: '+85264507651',
#          to: guardian.phone,
#          body: " #{self.user.username} pressed the Pinic Key ! "
#        )
#      end
  	end
  end

end
