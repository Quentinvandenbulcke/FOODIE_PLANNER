class AddColumnToIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :unit, :string
  end
end
