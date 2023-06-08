class CreateGroceryLists < ActiveRecord::Migration[7.0]
  def change
    create_table :grocery_lists do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.decimal :quantity
      t.references :grocery, null: false, foreign_key: true

      t.timestamps
    end
  end
end
