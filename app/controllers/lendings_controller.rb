# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# app/controllers/lendings_controller.rb
class LendingsController < ApplicationController
  before_action :authenticate_user!

  def new
    # Super-admins should not lend books
    if current_user.super_admin?
      redirect_to books_path, alert: "Super-admin cannot lend books."
      return
    end

    # Only show books the user owns and that aren't already loaned out
    @books = current_user.books.reject(&:loaned_out?)
    # Only show non-admin users (excluding self)
    @users = User.where.not(id: current_user.id).reject(&:super_admin?)
    @lending = Lending.new
  end

  def create
    if current_user.super_admin?
      redirect_to books_path, alert: "Super-admin cannot lend books."
      return
    end

    @lending = Lending.new(lending_params)
    @lending.lender    = current_user
    @lending.loaned_at = Time.current

    if @lending.save
      redirect_to books_path,
                  notice: "Book successfully loaned to #{@lending.borrower.first_name}."
    else
      # Re-load collections for re-rendering the form
      @books = current_user.books.reject(&:loaned_out?)
      @users = User.where.not(id: current_user.id).reject(&:super_admin?)
      flash.now[:alert] = "Could not lend book: #{@lending.errors.full_messages.to_sentence}"
      render :new, status: :unprocessable_entity
    end
  end

  def return
    lending = Lending.find(params[:id])

    if lending.borrower == current_user && lending.returned_at.nil?
      lending.update(returned_at: Time.current)
      redirect_to books_path, notice: "Book returned successfully."
    else
      redirect_to books_path, alert: "You are not authorized to return this book."
    end
  end

  private

  def lending_params
    params.require(:lending).permit(:book_id, :borrower_id)
  end
end

