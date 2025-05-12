# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User deleted."
  end

  private

  def require_admin!
    redirect_to root_path, alert: "Not authorized!" unless current_user.admin?
  end
end

