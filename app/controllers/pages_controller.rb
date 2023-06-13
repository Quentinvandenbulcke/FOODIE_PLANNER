class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # @recipes = policy_scope(Recipe)
    @recipes = Recipe.all
    @top_recipes = @recipes.select { |recipe| recipe.rating == 5 }
    @meal_days = user_signed_in? ? current_user.meal_days : []
    @grocery = Grocery.new
    @favorites = user_signed_in? ? Recipe.where(favorites: current_user.favorites) : []
    @meal_day = MealDay.new
  end
end
