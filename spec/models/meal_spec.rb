require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_numericality_of(:gut_feeling).only_integer }
    it { should validate_numericality_of(:gut_feeling).is_greater_than_or_equal_to(-5) }
    it { should validate_numericality_of(:gut_feeling).is_less_than_or_equal_to(5) }
  end

  describe 'relationships' do
    it { should belong_to :user }

    it { should have_many :meal_dishes }
    it { should have_many(:dishes).through(:meal_dishes) }

    it { should have_many :meal_ingredients }
    it { should have_many(:ingredients).through(:meal_ingredients) }
  end

  describe 'instance methods' do
    it "can verify gut_feeling presence" do
      rated_meal = create(:meal)
      unrated_meal = create(:unrated_meal)

      expect(rated_meal.has_gut_feeling?).to eq(true)
      expect(unrated_meal.has_gut_feeling?).to eq(false)
    end

    it "can format date using localtime" do
      meal = create(:meal, created_at: "2019-05-13T12:30:00")

      expect(meal.localtime).to eq("Mon, May 13, 2019 at 06:30am").or eq("Mon, May 13, 2019 at 12:30pm")
    end

    it "can verify updated_at age is less than 1 day" do
      meal     = create(:meal)
      old_meal = create(:meal, updated_at: DateTime.now.prev_day)

      expect(meal.one_day_old?).to eq(false)
      expect(old_meal.one_day_old?).to eq(true)
    end

    it "can verify created_at age is less than 3 days" do
      meal     = create(:meal)
      old_meal = create(:meal, created_at: DateTime.now.prev_day(3))

      expect(meal.three_days_old?).to eq(false)
      expect(old_meal.three_days_old?).to eq(true)
    end

    it "can create meal dishes" do
      meal = create(:meal)
      dish_1 = create(:dish)
      dish_2 = create(:dish)
      dish_array = [dish_1.id, dish_2.id]

      meal.create_meal_dishes(dish_array)
      expect(meal.dishes).to eq([dish_1, dish_2])
    end

    it "can create meal ingredients" do
      Faker::UniqueGenerator.clear # Clears used values for all generators
      Ingredient.destroy_all

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
      expect(meal.ingredients).to include(fi_1.ingredient,
                                          fi_2.ingredient,
                                          fi_3.ingredient,
                                          fi_4.ingredient
                                        )
    end
  end
end
