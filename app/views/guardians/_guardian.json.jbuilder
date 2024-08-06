json.extract! guardian, :id, :user_id, :name, :email, :phone, :guardian_user_id, :created_at, :updated_at
json.url guardian_url(guardian, format: :json)
