class GroceryList < ApplicationRecord
  belongs_to :ingredient
  belongs_to :grocery
  belongs_to :meal_day
end
