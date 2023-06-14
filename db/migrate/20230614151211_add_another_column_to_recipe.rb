class AddAnotherColumnToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :glucid, :float, default: 0
  end
end
