class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.integer :prep_time
      t.integer :rating
      t.integer :servings

      t.timestamps
    end
  end
end
