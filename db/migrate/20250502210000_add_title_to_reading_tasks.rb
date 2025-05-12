# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class AddTitleToReadingTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :reading_tasks, :title, :string
  end
end

