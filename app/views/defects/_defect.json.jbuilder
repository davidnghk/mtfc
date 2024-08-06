json.extract! defect, :id, :assignment_id, :defect_id, :rating, :remarks, :created_at, :updated_at
json.url defect_url(defect, format: :json)
