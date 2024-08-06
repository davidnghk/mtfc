json.set! :data do
  json.array! @business_staffs do |business_staff|
    json.partial! 'business_staffs/business_staff', business_staff: business_staff
    json.url  "
              #{link_to 'Show', business_staff }
              #{link_to 'Edit', edit_business_staff_path(business_staff)}
              #{link_to 'Destroy', business_staff, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end