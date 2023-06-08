class AddColumnsToGrocery < ActiveRecord::Migration[7.0]
  def change
    add_reference :groceries, :ingredient, null: false, foreign_key: true
  end
end
