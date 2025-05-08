module TaskCategoriesHelper
  def category_color_class(name)
    case name.downcase
    when "currently reading"
      "text-primary"
    when "finished"
      "text-success"
    when "must read"
      "text-danger"
    when "on deck"
      "text-warning"
    when "recommended"
      "text-info"
    else
      "text-muted"
    end
  end
end

