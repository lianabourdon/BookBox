# ---------------------------------------------------------------------------
# BookBox – COM214 Final Project (Spring 2025)
# Author contributions
#   Cam Bayusik      – Lending system, Select2 search UI, FAQ controller & view
#   Liana Bourdon   – ReadingTask workflow, Devise roles, deployment scripts
#   Annabelle Calvin – Catalogue & review features, Cloudinary, SCSS/Bootstrap
# ---------------------------------------------------------------------------

# app/controllers/reading_tasks_controller.rb

class ReadingTasksController < ApplicationController
  before_action :authenticate_user!
  # Only load @reading_task for mutating actions—not for show
  before_action :set_reading_task, only: %i[edit update mark_completed recommend destroy]

  # GET /reading_tasks
  def index
    @reading_tasks   = current_user.reading_tasks.where(completed: [false, nil])
    @task_categories = TaskCategory.visible_for(current_user)
  end

  # GET /reading_tasks/completed
  def completed
    @reading_tasks = current_user.reading_tasks
                                 .where(completed: true)
                                 .order(updated_at: :desc)
  end

  # GET /reading_tasks/:id
  def show
    @reading_task = ReadingTask.find(params[:id])
    # anyone in a shared category may view
  end

  # GET /reading_tasks/new
  def new
    @reading_task    = ReadingTask.new
    @books           = available_books_for(current_user)
    @task_categories = TaskCategory.visible_for(current_user)
    @priorities      = ReadingTask.priorities.keys
  end

  # POST /reading_tasks
  def create
    @reading_task      = ReadingTask.new(reading_task_params)
    @reading_task.user = current_user

    if @reading_task.save
      redirect_to reading_tasks_path, notice: "Task added!"
    else
      @books           = available_books_for(current_user)
      @task_categories = TaskCategory.visible_for(current_user)
      @priorities      = ReadingTask.priorities.keys
      render :new, status: :unprocessable_entity
    end
  end

  # GET /reading_tasks/:id/edit
  def edit
    @books           = available_books_for(current_user)
    @task_categories = TaskCategory.visible_for(current_user)
    @priorities      = ReadingTask.priorities.keys
  end

  # PATCH/PUT /reading_tasks/:id
  def update
    if @reading_task.update(reading_task_params)
      redirect_to @reading_task, notice: "Task updated!"
    else
      @books           = available_books_for(current_user)
      @task_categories = TaskCategory.visible_for(current_user)
      @priorities      = ReadingTask.priorities.keys
      render :edit, status: :unprocessable_entity
    end
  end

  # PATCH /reading_tasks/:id/mark_completed
  def mark_completed
    @reading_task.mark_completed!
    redirect_to reading_tasks_path, notice: "Task completed!"
  end

  # PATCH /reading_tasks/:id/recommend
  def recommend
    @reading_task.update!(recommended: !@reading_task.recommended)
    redirect_to reading_tasks_path, notice: "Recommendation updated!"
  end

  # DELETE /reading_tasks/:id
  def destroy
    # grab the category so we can send you back there
    category = @reading_task.task_category
    @reading_task.destroy

    redirect_to task_category_path(category),
                notice: "Task deleted."
  end

  private

  def set_reading_task
    @reading_task = ReadingTask.find(params[:id])
    return if @reading_task.user == current_user

    # nicely format the owner’s name/email
    owner_name = [@reading_task.user.first_name, @reading_task.user.last_name]
                   .compact
                   .reject(&:blank?)
                   .join(" ")
    owner = owner_name.presence ||
            @reading_task.user.username.presence ||
            @reading_task.user.email

    redirect_to root_path,
                alert: "Cannot edit this task — it belongs to #{owner}."
  end

  def reading_task_params
    params.require(:reading_task)
          .permit(:title, :book_id, :task_category_id, :priority, :completed)
  end

  def available_books_for(user)
    super_admin_id = User.find_by(email: ApplicationHelper::SUPER_ADMIN_EMAIL)&.id
    Book.where(user_id: [user.id, super_admin_id])
  end
end

