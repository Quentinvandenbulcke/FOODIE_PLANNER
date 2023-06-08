class ChangeColumnQuantityToIngredients < ActiveRecord::Migration[7.0]
  def change
    change_column :ingredients, :quantity, :decimal
  end
end
