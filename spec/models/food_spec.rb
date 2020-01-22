require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    # it { should validate_presence_of :brand }
    it { should validate_presence_of :upc }

    it { should validate_uniqueness_of(:upc).case_insensitive }
    it { should validate_numericality_of :upc }
    # it { should validate_length_of(:upc).is_equal_to(12) }
  end

  describe 'relationships' do
    it { should have_many :dish_foods }
    it { should have_many(:dishes).through(:dish_foods) }

    it { should have_many :food_ingredients }
    it { should have_many(:ingredients).through(:food_ingredients) }
  end

  describe 'instance methods' do
    it 'can create ingredients' do
      food = create(:food)
      food_info = '{"data":{"name":"CLASSICO, TOMATO & BASIL PASTA SAUCE, TOMATO & BASIL, TOMATO & BASIL","brand":"New World Pasta Company","upc":"041129077122","ingredients":["TOMATO PUREE","DICED TOMATOES IN JUICE"]}}'

      ingredient_list = JSON.parse(food_info)['data']['ingredients']

      food.create_ingredients(ingredient_list)
      expect(food.ingredients.pluck(:name)).to eq(['TOMATO PUREE', 'DICED TOMATOES IN JUICE'])
    end
  end
end
