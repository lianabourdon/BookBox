# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class RemoveDescriptionFromReadingTasks < ActiveRecord::Migration[7.2]
  def change
    if column_exists?(:reading_tasks, :description)
      remove_column :reading_tasks, :description, :text
    end
  end
end

