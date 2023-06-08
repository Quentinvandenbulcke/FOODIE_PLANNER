require 'bigdecimal'

class GroceriesController < ApplicationController
  def new
    @grocery = Grocery.new
    @meal_days = MealDay.all
    @dates = MealDay.all.map { |element| element[:date] }
    authorize @grocery
  end

  def show
    @grocery = Grocery.find(params[:id])
    @lists = GroceryList.select {|list| list.grocery_id == @grocery.id }
    @meals = MealDay.select {|meal| meal.grocery_id == @grocery.id }
    authorize @grocery
  end

  def create
    array_of_selected_meals = params[:grocery][:meal_day_ids]
    @grocery = Grocery.create(user: current_user)
    quantities = Hash.new(0)

    array_of_selected_meals.each do |meal|
      if !meal.empty?
        @meal = MealDay.find(meal.to_i)
        @meal.update(grocery_id: @grocery.id)
        @meal.recipe.ingredients.each do |ingredient|
          recipe_ingredient_qty = BigDecimal(ingredient.quantity)
          recipe_servings = @meal.recipe.servings
          meal_servings = @meal.quantity
          ingredient_quantity = ((recipe_ingredient_qty / recipe_servings) * meal_servings).round(2)
          quantities[ingredient.name] += ingredient_quantity
        end
      end
    end
    quantities.each do |ingredient_name, quantity|
      ingredient = Ingredient.find_by(name: ingredient_name)
      @grocery_list = GroceryList.new(
        grocery_id: @grocery.id,
        ingredient: ingredient,
        quantity: quantity
      )
      unless @grocery_list.save
        render :new, status: :unprocessable_entity
        return
      end
      authorize @grocery_list
    end
    authorize @grocery
    redirect_to grocery_path(@grocery)
  end
end


# def create
#   array_of_selected_meals = params[:grocery][:meal_day_ids]
#   @grocery = Grocery.create(user: current_user)
#   quantities = Hash.new(0)

#   array_of_selected_meals.each do |meal|
#     if !meal.empty?
#       @meal = MealDay.find(meal.to_i)
#       @meal.recipe.ingredients.each do |ingredient|
#         recipe_ingredient_qty = BigDecimal(ingredient.quantity)
#         recipe_servings = @meal.recipe.servings
#         meal_servings = @meal.quantity
#         ingredient_quantity = ((recipe_ingredient_qty / recipe_servings) * meal_servings).round(2)

#         quantities[ingredient] += ingredient_quantity
#       end
#     end
#   end

#   quantities.each do |ingredient, quantity|
#     @grocery_list = GroceryList.new(
#       grocery_id: @meal.grocery_id,
#       ingredient: ingredient,
#       quantity: quantity,
#       grocery: @grocery
#     )
#     unless @grocery_list.save
#       render :new, status: :unprocessable_entity
#       return
#     end
#     authorize @grocery_list
#   end

#   authorize @grocery
#   redirect_to groceries_new_path
# end
