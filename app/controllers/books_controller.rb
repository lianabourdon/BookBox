# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# app/controllers/books_controller.rb
class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book,           only: %i[show edit update destroy]
  before_action :authorize_editing!, only: %i[edit update destroy]

  # ──────────────────────────────────────────────────────────────
  # LIST
  # ──────────────────────────────────────────────────────────────
  def index
    super_admin = User.find_by(email: ApplicationHelper::SUPER_ADMIN_EMAIL)
    @genres     = Genre.order(:name)

    per_page    = (params[:per_page] || 6).to_i.clamp(6, 24)

    # books I own + books the super-admin shared with everyone
    owned_ids   = Book.where(user_id: [current_user.id, super_admin&.id]).pluck(:id)

    # books I’m currently borrowing
    borrowed_ids = Book.joins(:lendings)
                       .where(lendings: { borrower_id: current_user.id,
                                          returned_at: nil })
                       .pluck(:id)

    visible_ids = owned_ids + borrowed_ids
    scope       = Book.where(id: visible_ids)
    scope       = scope.where(genre_id: params[:genre_id]) if params[:genre_id].present?

    @books      = scope.order(:title).page(params[:page]).per(per_page)
  end

  # ──────────────────────────────────────────────────────────────
  # SHOW
  # ──────────────────────────────────────────────────────────────
  def show
    @reading_tasks = @book.reading_tasks.includes(:task_category, :user)
  end

  # ──────────────────────────────────────────────────────────────
  # NEW / CREATE
  # ──────────────────────────────────────────────────────────────
  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to @book, notice: "Book added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # ──────────────────────────────────────────────────────────────
  # EDIT / UPDATE
  # ──────────────────────────────────────────────────────────────
  def edit; end

  def update
    if @book.update(book_update_params)
      redirect_to @book, notice: "Book updated."
    else
      # oversize cover, blank title, etc. – show errors inline
      render :edit, status: :unprocessable_entity
    end
  end

  # ──────────────────────────────────────────────────────────────
  # DESTROY
  # ──────────────────────────────────────────────────────────────
  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book deleted."
  end

  # ──────────────────────────────────────────────────────────────
  # PRIVATE HELPERS
  # ──────────────────────────────────────────────────────────────
  private

  def set_book
    @book = Book.find(params[:id])
  end

  # rubber-stamp that *I* own this record
  def authorize_editing!
    return if @book.user == current_user

    redirect_to books_path, alert: "You’re not allowed to modify this book."
  end

  # strong params – create
def book_params
  params.require(:book).permit(
    :title, :author, :description,
    :genre_id, :published_year,
    :cover,
    :remove_cover          # ← add this line
  )
end

  # strong params – update
  # (nothing extra right now, but kept separate so you can
  #  later allow :remove_cover or other maintenance flags)
  def book_update_params
    book_params
  end
end

