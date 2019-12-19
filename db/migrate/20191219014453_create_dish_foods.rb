class CreateDishFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :dish_foods do |t|
      t.references :dish, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
