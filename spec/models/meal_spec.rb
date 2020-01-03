require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
  end

  describe 'relationships' do
    it { should belong_to :user }

    it { should have_many :meal_dishes }
    it { should have_many(:dishes).through(:meal_dishes) }

    it { should have_many :meal_ingredients }
    it { should have_many(:ingredients).through(:meal_ingredients) }
  end

  describe 'instance methods' do
    it "can create meal dishes" do
      meal = create(:meal)
      dish_1 = create(:dish)
      dish_2 = create(:dish)
      dish_array = [dish_1.id, dish_2.id]

      meal.create_meal_dishes(dish_array)
      expect(meal.dishes).to eq([dish_1, dish_2])
    end

    it "can create meal ingredients" do
      fi_1 = create(:food_ingredient)
      fi_2 = create(:food_ingredient)
      fi_3 = create(:food_ingredient)
      fi_4 = create(:food_ingredient)
      dish_1 = create(:dish)
      dish_2 = create(:dish)
      dish_1.foods.push(fi_1.food, fi_2.food)
      dish_2.foods.push(fi_3.food, fi_4.food)
      meal = create(:meal)
      meal.dishes.push(dish_1, dish_2)

      meal.create_meal_ingredients
      expect(meal.ingredients).to eq([fi_1.ingredient,
                                      fi_2.ingredient,
                                      fi_3.ingredient,
                                      fi_4.ingredient]
                                    )
    end
  end
end
