class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @recipes = policy_scope(Recipe)
    @categories = []
    @recipes.each do |recipe|
      @categories << recipe.category unless @categories.include?(recipe.category)
    end

    if params[:query].present?
      @recipes = @recipes.search_by_name_desc_cat(params[:query])
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @meal_day = MealDay.new
    authorize @recipe
    @ingredients = @recipe.ingredients
  end

  # private

  # def params_recipe
  #   params.require(:recipe).permit(:name, :description, :prep_time, :rating, :servings)
  # end
end
