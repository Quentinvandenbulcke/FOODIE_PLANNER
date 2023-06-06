class MealDaysController < ApplicationController
  def index
    @meal_days = policy_scope(MealDay)
  end

  def new
    @meal_day = MealDay.new
    @recipe = Recipe.find(params[:recipe_id])
    authorize @meal_day
  end
end
