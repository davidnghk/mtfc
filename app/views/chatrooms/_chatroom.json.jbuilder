json.extract! chatroom, :id, :name, :admin_user_id, :created_at, :updated_at
json.url chatroom_url(chatroom, format: :json)
