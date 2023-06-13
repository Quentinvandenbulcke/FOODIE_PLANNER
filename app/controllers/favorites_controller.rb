class FavoritesController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def index
    @favorites = policy_scope(Favorite)
    @favorites = current_user.favorites
    @fav_recipes = []
    @favorites.each do |favorite|
      @fav_recipes << Recipe.find(favorite.recipe_id)
    end
  end

  def create
    @favorite = Favorite.new(user: current_user, recipe: Recipe.find(params[:recipe_id]))
    authorize @favorite
    @favorite.save!
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = @recipe.favorites.where(user: current_user)
    @favorite.first.destroy
    authorize @favorite
  end

  private

  def fav_params
    params.require(:favorite).permit(:recipe_id)
  end
end
