json.extract! announcement, :id, :start_at, :end_at, :content, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
