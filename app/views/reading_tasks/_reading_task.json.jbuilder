json.extract! reading_task, :id, :user_id, :book_id, :task_category_id, :priority, :completed, :created_at, :updated_at
json.url reading_task_url(reading_task, format: :json)
