class MealDaysController < ApplicationController
  def index
    @meal_days = policy_scope(MealDay)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @meal_day = MealDay.new(recipe_params)
    @meal_day.recipe = @recipe
    @meal_day.user = current_user

    if @meal_day.save
      redirect_to meal_days_path
    else
      render "recipes/show", status: :unprocessable_entity
    end
    authorize @meal_day
  end

  private

  def recipe_params
    params.require(:meal_day).permit(:date, :quantity)
  end
end
