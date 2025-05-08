# app/controllers/task_categories_controller.rb
class TaskCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_category, only: %i[show edit update destroy]
  before_action :authorize_owner!,    only: %i[edit update destroy]

  # GET /task_categories
  def index
    @task_categories = TaskCategory.visible_for(current_user)
  end

  # GET /task_categories/:id
  def show
    # @task_category is loaded in set_task_category
  end

  # GET /task_categories/new
  def new
    @task_category = current_user.task_categories.new
  end

  # POST /task_categories
  def create
    @task_category = current_user.task_categories.new(category_params)
    if @task_category.save
      redirect_to task_categories_path, notice: "Category created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /task_categories/:id/edit
  def edit
    # @task_category is loaded in set_task_category
  end

  # PATCH/PUT /task_categories/:id
  def update
    if @task_category.update(category_params)
      redirect_to @task_category, notice: "Category updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /task_categories/:id
  def destroy
    if @task_category.destroy
      redirect_to task_categories_path, notice: "Category deleted."
    else
      # AR has added errors (via dependent: :restrict_with_error)
      msg = @task_category.errors.full_messages.to_sentence
      redirect_to task_category_path(@task_category), alert: msg
    end
  end

  private

  # scopes lookup to current_user + super-admin
  def set_task_category
    @task_category =
      TaskCategory
        .visible_for(current_user)
        .find(params[:id])
  end

  # only owner or super-admin may edit/update/destroy
  def authorize_owner!
    return if @task_category.user == current_user
    return if current_user.super_admin?

    redirect_to task_categories_path,
                alert: "Not authorized to modify that category."
  end

  def category_params
    params.require(:task_category).permit(:name, :description, :color)
  end
end

