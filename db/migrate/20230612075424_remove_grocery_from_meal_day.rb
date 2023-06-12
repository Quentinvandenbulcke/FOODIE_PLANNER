class RemoveGroceryFromMealDay < ActiveRecord::Migration[7.0]
  def change
    remove_reference :meal_days, :grocery, foreign_key: true
  end
end
