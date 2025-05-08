# app/controllers/static_controller.rb
class StaticController < ApplicationController
  # skip login only for the credits page
  skip_before_action :authenticate_user!, only: [:credits]

  def credits
    # nothing special needed here—just render app/views/static/credits.html.erb
  end
end

