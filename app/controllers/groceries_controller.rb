require 'bigdecimal'

class GroceriesController < ApplicationController
  def index
    @groceries = policy_scope(Grocery)
  end

  def show
    @grocery = Grocery.find(params[:id])
    @lists = []
    @grocery.grocery_lists.each do |list|
      existing_list = @lists.find { |l| l.ingredient.name == list.ingredient.name }
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
    populate_grocery_items(meal_days_id)
    authorize @grocery
    redirect_to grocery_path(@grocery)
  end

  private

  def populate_grocery_items(meal_days_id)
    @grocery = Grocery.create(user: current_user)
    meal_days_id.each do |meal|
      @meal = MealDay.find(meal.to_i)
      @meal.recipe.ingredients.each do |ingredient|
        recipe_ingredient_qty = BigDecimal(ingredient.quantity)
        ingredient_quantity = ((recipe_ingredient_qty / @meal.recipe.servings) * @meal.quantity).round(2)
        @grocery_list = @grocery.grocery_lists.new(
          ingredient: Ingredient.find_by(name: ingredient.name),
          quantity: ingredient_quantity,
          meal_day: @meal)
        unless @grocery_list.save
          render :new, status: :unprocessable_entity
          return
        end
      end
      authorize @grocery_list
    end
  end
end
