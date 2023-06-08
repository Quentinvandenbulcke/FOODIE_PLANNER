class AddColumnToMealDays < ActiveRecord::Migration[7.0]
  def change
    add_reference :meal_days, :grocery, null: false, foreign_key: true
  end
end
