require "open-uri"

class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

  def index
    @recipes = policy_scope(Recipe)
    @categories = []
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
      @categories << recipe.category unless @categories.include?(recipe.category)
    end

    if params[:query].present?
      @recipes = @recipes.search_by_name_desc_cat(params[:query])
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    if @recipe.name.include?(":")
      @recipe.name = @recipe.name.split(":")[-1]
    end
    if @recipe.name.include?("Recipes")
      @recipe.name = @recipe.name.gsub("Recipes", "")
    end
    if @recipe.name.include?("Recipe")
      @recipe.name = @recipe.name.gsub("Recipe", "")
    end
    if @recipe.name.include?("recipe")
      @recipe.name = @recipe.name.gsub("recipe", "")
    end
    if @recipe.name.include?("recipes")
      @recipe.name = @recipe.name.gsub("recipes", "")
    end
    @meal_day = MealDay.new
    authorize @recipe
    @ingredients = @recipe.ingredients
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(params_recipe)
    if @recipe.photo.blank?
      photo_url = "https://source.unsplash.com/random/?#{@recipe.name}"
      photo = URI.open(photo_url)
      @recipe.photo.attach(io: photo, filename: "#{@recipe.name.split().join("_")}.png", content_type: "image/png")
    end
    if @recipe.save!
      Favorite.create(user: current_user, recipe: @recipe)
      redirect_to new_recipe_ingredient_path(@recipe)
    else
      render :new, status: :unprocessable_entity, notice: "Fill the form correctly dummy"
      redirect_to root_path
    end
    authorize @recipe
  end

  private

  def params_recipe
    params.require(:recipe).permit(:name, :description, :prep_time, :rating, :servings, :category, :photo)
  end
end
