class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @recipes = policy_scope(Recipe)
    @meal_days = current_user.meal_days
    # @meal_days = MealDay.where(
    #   starts_at: date.beginning_of_month.beginning_of_week..date.end_of_month.end_of_week
    # )
  end
end
