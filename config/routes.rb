# bookbox/config/routes.rb
Rails.application.routes.draw do
  # ─── Static ───────────────────────────────────────────────────────────────────
  get  "/credits", to: "static#credits"
  get  "/welcome", to: "welcome#index"      # nice-to-have alias for root
  get "/faq", to: "static#faq", as: :faq
  # ─── Authentication ───────────────────────────────────────────────────────────
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_scope :user do
    get "/users/confirm_delete",
        to:  "users/registrations#confirm_delete",
        as:  :confirm_delete_user
  end

  # ─── Admin namespace ──────────────────────────────────────────────────────────
  namespace :admin do
    resources :users, only: %i[index update destroy] do
      patch :reset_password, on: :member
    end
  end

  # ─── Core app resources ───────────────────────────────────────────────────────
  resources :books do
    resources :reviews, only: %i[create edit update destroy]
  end

  resources :genres,         only: %i[index show]
  resources :task_categories # full CRUD is fine here

  resources :reading_tasks do
    member     { patch :mark_completed; patch :recommend }
    collection { get  :completed }
  end

  resources :lendings, only: %i[new create] do
    patch :return, on: :member
  end

  # ─── Root ─────────────────────────────────────────────────────────────────────
  root "welcome#index"
end

