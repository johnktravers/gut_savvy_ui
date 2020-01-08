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

  describe 'instance methods' do
    before(:all) do
      @user         = create(:user)

      @meal_1       = create(:meal, user: @user, gut_feeling: 3)
      @meal_2       = create(:meal, user: @user, gut_feeling: -5)

      @ingredient_1 = create(:ingredient) # found once (food_1), eaten 1 time, rating (3) #
      @ingredient_2 = create(:ingredient) # found twice (foods 2, 3), eaten 4 times, ratings (3, 3, -5, -5), avg -1 #
      @ingredient_3 = create(:ingredient) # found thrice (foods 2, 3, 4), eaten 5 times, ratings (3, 3, -5, -5, -5), avg -1.8 #
      @ingredient_4 = create(:ingredient) # found 4 times (foods 1, 2, 3, 4), eaten 6 times, ratings (3, 3, 3, -5, -5, -5), avg -1 #

      @food_1       = create(:food) # eaten once (dish_1)
      @food_2       = create(:food) # eaten twice (dishes 1, 2)
      @food_3       = create(:food) # eaten twice (dishes 1, 2)
      @food_4       = create(:food) # eaten once (dish_2)

      create(:food_ingredient, food: @food_1, ingredient: @ingredient_1)
      create(:food_ingredient, food: @food_1, ingredient: @ingredient_4)

      create(:food_ingredient, food: @food_2, ingredient: @ingredient_2)
      create(:food_ingredient, food: @food_2, ingredient: @ingredient_3)
      create(:food_ingredient, food: @food_2, ingredient: @ingredient_4)

      create(:food_ingredient, food: @food_3, ingredient: @ingredient_2)
      create(:food_ingredient, food: @food_3, ingredient: @ingredient_3)
      create(:food_ingredient, food: @food_3, ingredient: @ingredient_4)

      create(:food_ingredient, food: @food_4, ingredient: @ingredient_3)
      create(:food_ingredient, food: @food_4, ingredient: @ingredient_4)

      create(:meal_ingredient, meal: @meal_1, ingredient: @ingredient_1)
      create_list(:meal_ingredient, 2, meal: @meal_1, ingredient: @ingredient_2)
      create_list(:meal_ingredient, 2, meal: @meal_1, ingredient: @ingredient_3)
      create_list(:meal_ingredient, 3, meal: @meal_1, ingredient: @ingredient_4)

      create_list(:meal_ingredient, 2, meal: @meal_2, ingredient: @ingredient_2)
      create_list(:meal_ingredient, 3, meal: @meal_2, ingredient: @ingredient_3)
      create_list(:meal_ingredient, 3, meal: @meal_2, ingredient: @ingredient_4)
    end

    it 'can count how many times a user has eaten an ingredient' do
      expect(@ingredient_1.times_eaten(@user)).to eq(1)
      expect(@ingredient_2.times_eaten(@user)).to eq(4)
      expect(@ingredient_3.times_eaten(@user)).to eq(5)
      expect(@ingredient_4.times_eaten(@user)).to eq(6)
    end

    it 'can return average gut feeling for ingredient across all meals' do
      expect(@ingredient_1.average_gut_feeling(@user)).to eq(3)
      expect(@ingredient_2.average_gut_feeling(@user)).to eq(-1)
      expect(@ingredient_3.average_gut_feeling(@user)).to eq(-1.8)
      expect(@ingredient_4.average_gut_feeling(@user)).to eq(-1)
    end

    it 'can return all foods consumed by user which contain ingredient' do
      expected_1 = [@food_1]
      expected_2 = [@food_2, @food_3]
      expected_3 = [@food_2, @food_3, @food_4]
      expected_4 = [@food_1, @food_2, @food_3, @food_4]

      expect(@ingredient_1.all_foods(@user)).to eq(expected_1)
      expect(@ingredient_2.all_foods(@user)).to eq(expected_2)
      expect(@ingredient_3.all_foods(@user)).to eq(expected_3)
      expect(@ingredient_4.all_foods(@user)).to eq(expected_4)
    end
  end
end
