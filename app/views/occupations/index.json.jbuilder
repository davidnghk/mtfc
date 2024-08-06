json.set! :data do
  json.array! @occupations do |occupation|
    json.partial! 'occupations/occupation', occupation: occupation
    json.url  "
              #{link_to 'Show', occupation }
              #{link_to 'Edit', edit_occupation_path(occupation)}
              #{link_to 'Destroy', occupation, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end