module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Wagered App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def user_avatar_url(user)
    if user.image
      user.image.source.icon40.url
    else
      "https://s3.amazonaws.com/wagerednumerotres/images/fallback/image60_default.jpg"
    end
  end

  def format_date(date)
    date.strftime("%B %e, %Y")
  end
end
