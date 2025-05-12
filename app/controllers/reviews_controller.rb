# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: %i[edit update destroy]
  before_action :authorize_review!, only: %i[edit update destroy]

  def create
    @review = @book.reviews.build(review_params.merge(user: current_user))
    if @review.save
      redirect_to book_path(@book), notice: 'Review posted successfully.'
    else
      redirect_to book_path(@book), alert: @review.errors.full_messages.to_sentence
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to book_path(@book), notice: 'Review updated.'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to book_path(@book), notice: 'Review deleted.'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def authorize_review!
    redirect_to(book_path(@book), alert: 'Not authorized.') unless @review.user == current_user
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end

