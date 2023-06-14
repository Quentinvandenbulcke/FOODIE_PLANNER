class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

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

  def new
    @recipe = Recipe.new
    # @ingredient = Ingredient.new
    authorize @recipe
    # authorize @ingredient
  end

  def create
    @recipe = Recipe.new(params_recipe)
    if @recipe.save!
      Favorite.create(user: current_user, recipe: @recipe)
      # redirect_to recipe_path(@recipe)
      redirect_to new_recipe_ingredient_path(@recipe)
    else
      render :new, status: :unprocessable_entity, notice: "Fill the form correctly dummy"
      redirect_to root_path
    end
    authorize @recipe
  end

  # def edit
  #   @recipe = Recipe.find(params[:id])
  # end

  # def update
  #   @recipe = Recipe.find(params[:id])
  #   if @recipe.save!
  #     redirect_to recipe_path(@recipe)
  #   else
  #     render "recipes/show", status: :unprocessable_entity
  #     redirect_to root_path
  #   end
  # end

  private

  def params_recipe
    params.require(:recipe).permit(:name, :description, :prep_time, :rating, :servings, :category, :photo)
  end
end
