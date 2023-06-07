class GroceriesController < ApplicationController
  def new
    @grocery = Grocery.new
    @meal_days = MealDay.all
    @dates = MealDay.all.map { |element| element[:date] }
    authorize @grocery
  end

  def create

  end
end
