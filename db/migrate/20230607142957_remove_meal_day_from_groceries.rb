class RemoveMealDayFromGroceries < ActiveRecord::Migration[7.0]
  def change
    remove_reference :groceries, :meal_day, null: false, foreign_key: true
    remove_reference :groceries, :ingredient, null: false, foreign_key: true
    remove_column :groceries, :qty_to_order
  end
end
