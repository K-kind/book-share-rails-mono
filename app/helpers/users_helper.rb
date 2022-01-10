module UsersHelper
  def user_icon(user, size = 'medium')
    image = user.image.attached? ? user.image : 'default-icon.png'
    size_num =
      case size
      when 'small' then 10
      when 'medium' then 12
      when 'large' then 32
      end
    image_tag image, class: "object-fill border rounded-full w-#{size_num} h-#{size_num}"
  end
end
