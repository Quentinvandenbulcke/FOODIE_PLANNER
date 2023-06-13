class CreateGroceryDelta < ActiveRecord::Migration[7.0]
  def change
    create_table :grocery_deltas do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :grocery, null: false, foreign_key: true
      t.decimal :quantity

      t.timestamps
    end
  end
end
