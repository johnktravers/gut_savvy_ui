require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'relationships' do
    it { should have_many :food_ingredients }
    it { should have_many(:foods).through(:food_ingredients) }

    it { should have_many :meal_ingredients }
    it { should have_many(:meals).through(:meal_ingredients) }
  end

  describe 'class methods' do
    it 'to_data' do
      user = create(:user)

      meal_1 = create(:meal, user: user, gut_feeling: -5)
      meal_2 = create(:meal, user: user, gut_feeling: -4)
      meal_3 = create(:meal, user: user, gut_feeling: -3)
      meal_4 = create(:meal, user: user, gut_feeling: -2)
      meal_5 = create(:meal, user: user, gut_feeling: -1)
      meal_6 = create(:meal, user: user, gut_feeling: 0)
      meal_7 = create(:meal, user: user, gut_feeling: 1)
      meal_8 = create(:meal, user: user, gut_feeling: 2)
      meal_9 = create(:meal, user: user, gut_feeling: 3)
      meal_10 = create(:meal, user: user, gut_feeling: 4)
      meal_11 = create(:meal, user: user, gut_feeling: 5)
      meal_12 = create(:meal, user: user, gut_feeling: 2)

      ingredient_1 = create(:ingredient)  # avg: -4.0
      ingredient_2 = create(:ingredient)  # avg: -1.0
      ingredient_3 = create(:ingredient)  # avg: -3.67
      ingredient_4 = create(:ingredient)  # avg: -0.67
      ingredient_5 = create(:ingredient)  # avg: -0.25
      ingredient_6 = create(:ingredient)  # avg: -1.33
      ingredient_7 = create(:ingredient)  # avg: +2.5
      ingredient_8 = create(:ingredient)  # avg: +0.25
      ingredient_9 = create(:ingredient)  # avg: +2.0
      ingredient_10 = create(:ingredient) # avg: +3.67
      ingredient_11 = create(:ingredient) # avg: +1.33
      ingredient_12 = create(:ingredient) # avg: +3.5

      meal_1.ingredients.push(ingredient_1, ingredient_3, ingredient_11)
      meal_2.ingredients.push(ingredient_1, ingredient_3, ingredient_8)
      meal_3.ingredients.push(ingredient_1, ingredient_2, ingredient_6)
      meal_4.ingredients.push(ingredient_4, ingredient_5, ingredient_3)
      meal_5.ingredients.push(ingredient_4, ingredient_5, ingredient_6)
      meal_6.ingredients.push(ingredient_8, ingredient_5, ingredient_6)
      meal_7.ingredients.push(ingredient_4, ingredient_9, ingredient_2)
      meal_8.ingredients.push(ingredient_8, ingredient_9, ingredient_5)
      meal_9.ingredients.push(ingredient_7, ingredient_8, ingredient_9)
      meal_10.ingredients.push(ingredient_10, ingredient_11)
      meal_11.ingredients.push(ingredient_10, ingredient_11, ingredient_12)
      meal_12.ingredients.push(ingredient_10, ingredient_12, ingredient_7)

      expected = [
        { avg_gut_feeling: 3.67, name: ingredient_10.name },
        { avg_gut_feeling: 3.50, name: ingredient_12.name },
        { avg_gut_feeling: 2.50, name: ingredient_7.name },
        { avg_gut_feeling: 2.00, name: ingredient_9.name },
        { avg_gut_feeling: 1.33, name: ingredient_11.name },
        { avg_gut_feeling: 0.25, name: ingredient_8.name }
      ]

      expect(user.sorted_ingredients('best', 6).to_data).to eq(expected)
    end
  end
end
