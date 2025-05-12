# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

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

