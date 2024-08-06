json.extract! room, :id, :category_id, :location_id, :accomodate, :area, :bed_type, :bath_room, :tv, :has_kitchen, :has_air, :has_intenet, :status, :condition, :created_at, :updated_at
json.url room_url(room, format: :json)
