class CreateFoodIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :food_ingredients do |t|
      t.references :food, foreign_key: true
      t.references :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
