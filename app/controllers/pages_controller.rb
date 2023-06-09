class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @recipes = policy_scope(Recipe)
    @meal_days = current_user.meal_days
    @grocery = Grocery.new
  end
end
