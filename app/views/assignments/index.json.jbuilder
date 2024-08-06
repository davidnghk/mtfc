json.array! @assignments do |assignment|
  date_format = assignment.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id assignment.id
  json.work_id assignment.work_id
  json.location_id assignment.location_id
  json.incharge_user_id assignment.incharge_user_id
  json.worker_user_id assignment.worker_user_id
  json.title assignment.work.code + ' ' + assignment.calendar_location + ' (' + assignment.user.username+ ')' 
  json.start assignment.start_datetime.strftime(date_format)
  json.end assignment.due_datetime.strftime(date_format)
  json.color assignment.color unless assignment.color.blank?
  json.allDay assignment.all_day_event? ? true : false
  json.update_url assignment_path(assignment, method: :patch)
  json.edit_url edit_assignment_path(assignment)
end