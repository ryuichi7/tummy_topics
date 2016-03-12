class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
    	t.string :name
      t.integer :recipe_id
      t.integer :ingredient_id
      t.string :measurement

      t.timestamps null: false
    end
  end
end
