class GroceryDeltasController < ApplicationController
  # skip_before_action :verify_authenticity_token
  def update
    @grocery = Grocery.find(params[:grocery_id])
    @ingredient = Ingredient.find(params[:id])
    find_initial_values
    @quantity_initial = @lists.find { |list| list.ingredient_id == params[:id].to_i && list.grocery_id == params[:grocery_id].to_i }.quantity
    @quantity_unit = params[:unit]
    if @quantity_unit == "kg"
      @quantity_input = params[:value].to_i * 1000
    else
      @quantity_input = params[:value].to_i
    end
    # @quantity_input = params[:value].to_i
    @quantity_delta = @quantity_input - @quantity_initial
    @grocery_delta = GroceryDelta.find_by(ingredient: params[:id], grocery_id: params[:grocery_id])
    if @grocery_delta
      @grocery_delta.quantity = @quantity_delta
    else
      @grocery_delta = GroceryDelta.new(
        ingredient: @ingredient,
        quantity: @quantity_delta,
        grocery: @grocery
      )
    end
    if @grocery_delta.save
      # debugger
      render json: @grocery_delta
    else
      render @grocery, status: :unprocessable_entity
    end
    authorize @grocery_delta
  end

  private

  def find_initial_values
    @lists = []
    @grocery.grocery_lists.each do |list|
      existing_list = @lists.find { |l| l.ingredient.name == list.ingredient.name }
      if @lists.any?(existing_list)
        existing_list.quantity += list[:quantity]
      else
        @lists << list
      end
    end
  end
end
