class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @recipes = Recipe.all.uniq { |recipe| recipe.name }

    @recipes.each do |recipe|
      if recipe.name.include?(":")
        recipe.name = recipe.name.split(":")[-1]
      end
      if recipe.name.include?("Recipes")
        recipe.name = recipe.name.gsub("Recipes", "")
      end
      if recipe.name.include?("Recipe")
        recipe.name = recipe.name.gsub("Recipe", "")
      end
      if recipe.name.include?("recipe")
        recipe.name = recipe.name.gsub("recipe", "")
      end
      if recipe.name.include?("recipes")
        recipe.name = recipe.name.gsub("recipes", "")
      end
    end
    @top_recipes = @recipes.select { |recipe| recipe.rating == 5 }
    @meal_days = user_signed_in? ? current_user.meal_days : []
    @grocery = Grocery.new
    @favorites = user_signed_in? ? Recipe.where(favorites: current_user.favorites) : []
    @meal_day = MealDay.new
  end
end
