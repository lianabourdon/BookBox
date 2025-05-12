# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /users/confirm_delete
  def confirm_delete
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    flash[:notice] = "Your account has been successfully deleted."
    redirect_to new_user_registration_path
  end

  # PUT /resource
  def update
    if resource.update_with_password(account_update_params)
      resource.update(force_password_change: false)
      flash[:notice] = "Your account has been updated."
      bypass_sign_in resource
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      render :edit
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end

