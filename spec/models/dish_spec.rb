require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :meal_dishes }
    it { should have_many(:meals).through(:meal_dishes) }

    it { should have_many :dish_foods }
    it { should have_many(:foods).through(:dish_foods) }
  end

  describe 'instance methods' do
    it 'can create dish foods' do
      food_1 = create(:food)
      food_2 = create(:food)
      session = {}
      session[:foods] = [food_1.id, food_2.id]
      dish = create(:dish)

      dish.create_dish_foods(session[:foods])

      expect(dish.foods).to eq([food_1, food_2])
    end
  end
end
