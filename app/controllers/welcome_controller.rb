# app/controllers/welcome_controller.rb
class WelcomeController < ApplicationController
  # don’t require login to see the landing page
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end
end

