json.array! @notifications do |notification|
  json.recipient notification.recipient.name
  json.content   notification.content
  json.sender    notification.user.name
end
