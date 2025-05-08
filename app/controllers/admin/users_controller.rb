# app/controllers/admin/users_controller.rb

module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin

    DEFAULT_TEMP_PASSWORD = 'password'.freeze

    # GET /admin/users
    def index
      @users = User.order(:email)
    end

    # PATCH /admin/users/:id
    def update
      @user = User.find(params[:id])

      if @user.super_admin?
        redirect_to admin_users_path, alert: "Cannot modify the super-admin account."
        return
      end

      make_admin = params.dig(:user, :admin) == "1"
      if @user.update(admin: make_admin)
        redirect_to admin_users_path, notice: "#{@user.email} admin status updated."
      else
        redirect_to admin_users_path, alert: "Failed to update admin status for #{@user.email}."
      end
    end

    # DELETE /admin/users/:id
    def destroy
      @user = User.find(params[:id])

      if @user.super_admin?
        redirect_to admin_users_path, alert: "Cannot delete the super-admin account."
      elsif @user == current_user
        redirect_to admin_users_path, alert: "You cannot delete your own account."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "#{@user.email} has been deleted."
      end
    end

    # PATCH /admin/users/:id/reset_password
    def reset_password
      @user = User.find(params[:id])

      if @user == current_user
        redirect_to admin_users_path, alert: "You cannot reset your own password here."
        return
      end

      if @user.super_admin?
        redirect_to admin_users_path, alert: "Cannot reset password for the super-admin account."
        return
      end

      @user.password              = DEFAULT_TEMP_PASSWORD
      @user.password_confirmation = DEFAULT_TEMP_PASSWORD
      @user.force_password_change = true

      if @user.save
        redirect_to admin_users_path,
                    notice: "#{@user.email}'s password has been reset to '#{DEFAULT_TEMP_PASSWORD}'."
      else
        redirect_to admin_users_path, alert: "Failed to reset password for #{@user.email}."
      end
    end

    private

    def ensure_admin
      redirect_to(root_path, alert: "Not authorized.") unless current_user.admin?
    end
  end
end

