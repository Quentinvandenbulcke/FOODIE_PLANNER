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
    @lists = GroceryList.select {|list| list.grocery_id = @grocery.id }
    @meals = MealDay.select {|meal| meal.grocery_id = @grocery.id }
    authorize @grocery
  end

  def create
    array_of_selected_meals = params[:grocery][:meal_day_ids]
    @grocery = Grocery.create(user: current_user)
    array_of_selected_meals.each do |meal|
      if !meal.empty?
        @meal = MealDay.find(meal.to_i)
        @meal.recipe.ingredients.each do |ingredient|
          recipe_ingredient_qty = BigDecimal(ingredient.quantity)
          recipe_servings = @meal.recipe.servings
          meal_servings = @meal.quantity
          ingredient_quantity = ((recipe_ingredient_qty / recipe_servings) * meal_servings).round(2)
          @grocery_list = GroceryList.new
          @grocery_list.grocery_id = @meal.grocery_id
          @grocery_list.ingredient = ingredient
          @grocery_list.quantity = ingredient_quantity
          @grocery_list.grocery = @grocery
          unless @grocery_list.save
            render :new, status: :unprocessable_entity
          end
          authorize @grocery_list
        end
      end
    end
    authorize @grocery
    redirect_to groceries_new_path
  end
end


# <% current_user.meal_days.each do |meal| %>
#   <% meal.recipe.ingredients.each do |ingredient| %>
#     <% ingredient_quantity = BigDecimal(ingredient.quantity)%>
#     <% recipe_servings = BigDecimal(meal.recipe.servings) %>
#     <% meal_quantity = BigDecimal(meal.quantity) %>
#     <div class="grocery-row">
#       <div class="grocery-cell"><%= ingredient.name %></div>
#       <div class="grocery-cell grocery-center"><%= ((ingredient_quantity / recipe_servings) * meal_quantity).round(2) %></div>
#       <div class="grocery-cell grocery-center"><%= ingredient.unit %></div>
