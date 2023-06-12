class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, recipe_id: params[:recipe_id])
    @recipe = Recipe.find(params[:recipe_id])
    @favorite.save
    authorize @favorite
    # redirect_to recipe_path(@recipe)
    # respond_to do |format|
    #   if @favorite.save
    #     format.html { redirect_to root_path }
    #     format.json
    #   else
    #     format.html { render "pages/home", status: :unprocessable_entity }
    #     format.json
    #   end
    # end
  end

  def show
    @favorites = current_user.favorites
    authorize @favorites
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
