class CreateMealDays < ActiveRecord::Migration[7.0]
  def change
    create_table :meal_days do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :date
      t.references :user, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
