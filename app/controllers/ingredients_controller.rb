class IngredientsController < ApplicationController
  def new
    @ingredient = Ingredient.new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient.recipe = @recipe
    authorize @ingredient
    authorize @recipe
    # render :new
    # raise
  end

  def create
    @ingredient = Ingredient.new(params_ingredient)
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient.recipe = @recipe
    authorize @ingredient
    authorize @recipe
    if @ingredient.save!
      # raise
      redirect_to new_recipe_ingredient_path(@recipe)
    else
      render :new, status: :unprocessable_entity, notice: "dsfvxvehmivugyhsdnuhbgvy"
      redirect_to root_path
    end
  end

  private

  def params_ingredient
    params.require(:ingredient).permit(:name, :quantity, :unit, :category)
  end
end
