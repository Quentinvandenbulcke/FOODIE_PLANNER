class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @recipes = policy_scope(Recipe)
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  # private

  # def params_recipe
  #   params.require(:recipe).permit(:name, :description, :prep_time, :rating, :servings)
  # end
end
