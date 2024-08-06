json.extract! booking, :id, :location_id, :start_date, :end_date, :client, :passport, :checkin_time, :checkout_time, :created_at, :updated_at
json.url booking_url(booking, format: :json)
