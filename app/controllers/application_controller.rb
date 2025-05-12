# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :check_password_change!
  before_action :set_current_user
  before_action :redirect_if_password_reset_required
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end

  private

  def set_current_user
    Current.user = current_user
  end

  def check_password_change!
    return unless user_signed_in?
    # optional: handle legacy password checks or notices here
  end

  def redirect_if_password_reset_required
    return unless user_signed_in?
    return unless current_user.force_password_change?

    safe_paths = [
      edit_user_registration_path,
      user_registration_path,
      destroy_user_session_path
    ]

    return if safe_paths.include?(request.path)

    flash[:alert] = "You must change your password before continuing."
    redirect_to edit_user_registration_path
  end
end

