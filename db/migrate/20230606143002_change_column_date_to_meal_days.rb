class ChangeColumnDateToMealDays < ActiveRecord::Migration[7.0]
  def change
    change_column :meal_days, :date, :date, using: 'date::date'
  end
end
