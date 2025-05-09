class StaticController < ApplicationController
  # Add :faq to the skip list so guests can view it
  skip_before_action :authenticate_user!, only: %i[home credits faq]

  def home; end
  def credits; end
  def faq; end         # ← make sure this action exists
end

