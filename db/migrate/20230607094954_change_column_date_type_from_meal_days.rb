class ChangeColumnDateTypeFromMealDays < ActiveRecord::Migration[7.0]
  def change
    change_column :meal_days, :date, :datetime
  end
end
