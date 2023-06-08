class CreateGroceries < ActiveRecord::Migration[7.0]
  def change
    create_table :groceries do |t|
      t.references :meal_day, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :qty_to_order

      t.timestamps
    end
  end
end
