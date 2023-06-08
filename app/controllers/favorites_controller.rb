class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, recipe_id: params[:recipe_id])
    @favorite.save
    authorize @favorite
    # redirect_to recipes_path
  end

  def destroy
    @recipe = Recipe.find(params[fav_params])
    @favorite = @recipe.favorites.where(user: current_user)
    @favorite.destroy
  end

  private

  def fav_params
    params.require(:favorite).permit(:recipe_id)
  end
end
