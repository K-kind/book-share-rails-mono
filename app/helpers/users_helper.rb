module UsersHelper
  def user_icon(user, size = 'medium')
    image = user.image.attached? ? user.image : 'default-icon.png'
    class_name =
      case size
      when 'small' then 'object-fill border rounded-full w-10 h-10'
      when 'medium' then 'object-fill border rounded-full w-12 h-12'
      when 'large' then 'object-fill border rounded-full w-32 h-32'
      end
    image_tag image, class: class_name
  end
end
