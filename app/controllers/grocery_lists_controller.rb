class GroceryListsController < ApplicationController
  def destroy
    @grocery_list = GroceryList.find(params[:id])
    @grocery = GroceryList.find(@grocery_list.id).grocery
    @ingredient = GroceryList.find(@grocery_list.id).ingredient
    @delta_deleted = GroceryDelta.find_by(ingredient_id: @ingredient, grocery_id: @grocery)
    if @grocery_list.destroy
      @delta_deleted.destroy if @delta_deleted
      redirect_to grocery_path(@grocery_list)
    end
    authorize @grocery_list
  end

  def refresh
    @grocery_list = GroceryList.find(params[:id])
    @grocery = GroceryList.find(@grocery_list.id).grocery
    @ingredient = GroceryList.find(@grocery_list.id).ingredient
    @delta_deleted = GroceryDelta.find_by(ingredient_id: @ingredient, grocery_id: @grocery)
    unless @delta_deleted.nil?
      @delta_deleted.destroy
      redirect_to grocery_path(@grocery_list)
    end
    authorize @grocery_list
    authorize @delta_deleted unless @delta_deleted.nil?
  end
end
