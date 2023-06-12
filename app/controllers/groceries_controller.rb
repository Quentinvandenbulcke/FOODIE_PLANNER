require 'bigdecimal'

class GroceriesController < ApplicationController
  def index
    @groceries = policy_scope(Grocery)
  end

  def show
    @grocery = Grocery.find(params[:id])
    @lists = []
    @grocery.grocery_lists.each do |list|
      existing_list = @lists.find {|l| l.ingredient.name == list.ingredient.name}
      if @lists.any?(existing_list)
        existing_list.quantity += list[:quantity]
      else
        @lists << list
      end
    end
    meal_day_ids = GroceryList.where(grocery: @grocery).pluck(:meal_day_id)
    @meals = MealDay.where(id: meal_day_ids)
    authorize @grocery
  end

  def create
    meal_days_id = MealDay.where(date: params[:grocery][:meal_days]).pluck(:id)
    @grocery = Grocery.create(user: current_user)
    meal_days_id.each do |meal|
      @meal = MealDay.find(meal.to_i)
      @meal.recipe.ingredients.each do |ingredient|
        @ingredient = Ingredient.find_by(name: ingredient.name)
        recipe_ingredient_qty = BigDecimal(ingredient.quantity)
        recipe_servings = @meal.recipe.servings
        meal_servings = @meal.quantity
        ingredient_quantity = ((recipe_ingredient_qty / recipe_servings) * meal_servings).round(2)
        @grocery_list= @grocery.grocery_lists.new(
          ingredient: @ingredient,
          quantity: ingredient_quantity,
          meal_day: @meal
        )
        unless @grocery_list.save
          render :new, status: :unprocessable_entity
          return
        end
      end
      authorize @grocery_list
    end
    authorize @grocery
    redirect_to grocery_path(@grocery)
  end

  private


end


# def create
#   days = params[:grocery][:meal_days]
#   array_of_selected_meals = []
#   current_user.meal_days.each do |meal|
#     days.each do |day|
#       array_of_selected_meals << meal.id if meal.date == day
#     end
#   end
#   @grocery = Grocery.create(user: current_user)
#   quantities = Hash.new(0)
#   array_of_selected_meals.each do |meal|
#     # if !meal.empty?
#     @meal = MealDay.find(meal.to_i)
#     @meal.update(grocery_id: @grocery.id)
#     @meal.recipe.ingredients.each do |ingredient|
#       recipe_ingredient_qty = BigDecimal(ingredient.quantity)
#       recipe_servings = @meal.recipe.servings
#       meal_servings = @meal.quantity
#       ingredient_quantity = ((recipe_ingredient_qty / recipe_servings) * meal_servings).round(2)
#       quantities[ingredient.name] += ingredient_quantity
#     end
#   end
#   quantities.each do |ingredient_name, quantity|
#     ingredient = Ingredient.find_by(name: ingredient_name)
#     @grocery_list = GroceryList.new(
#       grocery_id: @grocery.id,
#       ingredient: ingredient,
#       quantity: quantity
#     )
#     unless @grocery_list.save
#       render :new, status: :unprocessable_entity
#       return
#     end
#     authorize @grocery_list
#   end
#   authorize @grocery
#   redirect_to grocery_path(@grocery)
# end
