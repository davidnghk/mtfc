date_format = duty.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id duty.id
json.work_id duty.work_id
json.location_id duty.location_id
json.user_id duty.user_id
json.title duty.work.display_name + ' ' + duty.location.display_name + ' (' + duty.user.username+ ')' 
json.start duty.start_date.strftime(date_format)
json.end duty.end_date.strftime(date_format)

json.color duty.color unless duty.color.blank?
json.allDay duty.all_day_event? ? true : false

json.update_url duty_path(duty, method: :patch)
json.edit_url edit_duty_path(duty)
 