class AddColumnToGroceryList < ActiveRecord::Migration[7.0]
  def change
    add_reference :grocery_lists, :meal_day, null: false, foreign_key: true
  end
end
