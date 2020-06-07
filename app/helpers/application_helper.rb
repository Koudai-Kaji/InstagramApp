module ApplicationHelper

  def full_title(string = "")

    base_title = "Instagram Clone App"

    if string.empty?
      return base_title
    else
      return "#{string} | #{base_title}"
    end

  end

end
