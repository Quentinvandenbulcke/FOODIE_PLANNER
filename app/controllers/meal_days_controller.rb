class MealDaysController < ApplicationController
  def index
  end

  def new
    @meal_day = MealDay.new
    @recipe = Recipe.find(params[:recipe_id])
  end
end
