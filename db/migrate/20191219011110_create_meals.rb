class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :title
      t.integer :gut_feeling
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
