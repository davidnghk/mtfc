json.extract! occupation, :id, :location_id, :checkin_datetime, :due_date, :checkout_datetime, :customer, :passport, :price, :total, :status, :created_at, :updated_at
json.url occupation_url(occupation, format: :json)
