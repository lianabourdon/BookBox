module ApplicationHelper
  SUPER_ADMIN_EMAIL = 'admin@example.com'.freeze

  def super_admin?
    user_signed_in? && current_user.email == SUPER_ADMIN_EMAIL
  end

  # Builds a consistent, colorful page heading with an icon.
  #
  #   page_header "fas fa-book-reader", "My Reading Tasks", "tasks"
  #
  # `flavor` maps to a CSS class (.page-title.tasks, etc.) you define in custom.scss.
  def page_header(icon_css, text, flavor = "")
    content_tag :h1, class: "page-title #{flavor}" do
      concat content_tag(:i, "", class: icon_css)
      concat " "
      concat text
    end
  end
end

