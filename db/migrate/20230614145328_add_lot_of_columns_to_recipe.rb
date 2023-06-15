class AddLotOfColumnsToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :calories, :float, default: 0
    add_column :recipes, :carbon, :string, default: "tba"
    add_column :recipes, :fat, :float, default: 0
    add_column :recipes, :protein, :float, default: 0
    add_column :recipes, :sugar, :float, default: 0
  end
end
