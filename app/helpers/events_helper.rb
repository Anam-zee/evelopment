module EventsHelper
  def user_avatar_with_initials(username)
    initials = username.split.map(&:chr).join.upcase[0..1]
    random_color = random_hex_color(username)

    content_tag(:div, class: 'relative') do
      content_tag(:div, initials, class: "avatar w-12 h-12 text-white font-bold flex justify-center border border-white items-center", style: "background-color: #{random_color};")
    end
  end

  private

  def random_hex_color(name)
    hash_value = Digest::MD5.hexdigest(name)[0..5]
    "##{hash_value}"
  end

  def is_joined(event, user)
    event.joiners.include?(user)
  end

  def is_user_event(event, user)
    event.organizer.eql?(user)
  end
end