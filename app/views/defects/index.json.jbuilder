json.set! :data do
  json.array! @defects do |defect|
    json.partial! 'defects/defect', defect: defect
    json.url  "
              #{link_to 'Show', defect }
              #{link_to 'Edit', edit_defect_path(defect)}
              #{link_to 'Destroy', defect, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end