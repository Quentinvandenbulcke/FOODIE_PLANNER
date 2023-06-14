class GroceryListsController < ApplicationController
  def destroy
    @list = GroceryList.find(params[:id])
    if @list.destroy
      redirect_to grocery_path(@list)
    end
    authorize @list
  end

  def refresh
    raise
  end
end
