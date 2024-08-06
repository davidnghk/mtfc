module ApplicationHelper
  include LetterAvatar::AvatarHelper

  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def user_avatar(user, size=40)
    if user.avatar.attached?
      user.avatar.variant(resize: "#{size}x#{size}!")
    else
      #image_tag 'dummy.jpg'
      # gravatar_image_tag('junk', :alt => 'default', :gravatar => { :default => 'https://assets.github.com/images/gravatars/gravatar-140.png' })
      #gravatar_image_url(user.email, size: size, :gravatar => { :secure => true } )
      letter_avatar_url(user.username, 30)
    end
  end
 
  def status_icon(status)
    case status   
      when 'booked'
        'inbox'
      when 'ordered'
        'assignment'
      when 'acknowledged'
        'schedule'
      when 'finished'
        'done'
      when 'completed'
        'done_all'
      when 'assigned'
        'person_pin'
      when 'cancelled'
        'cancel'
      when 'rejected'
        'thumb_down_alt'
      when 'working'
        'update'
      else
        "contact_support"
      end
  end

  def room_status_icon(status)
    case status 
      when 'Occupied'
        'hotel'
      when 'Vacant'
        'home'
      else
        "pan_tool"
      end
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def render_stars(value)
    output = ''
    if (1..5).include?(value.floor)
      value.floor.times { output += image_tag('star-on.png')}
    end
    if value == (value.floor + 0.5) && value.to_i != 5
      output += image_tag('star-half.png')
    end
    output.html_safe
  end

end



