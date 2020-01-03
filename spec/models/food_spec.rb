require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :brand }
    it { should validate_presence_of :upc }

    it { should validate_uniqueness_of(:upc).case_insensitive }
    it { should validate_numericality_of :upc }
    it { should validate_length_of(:upc).is_equal_to(12) }
  end

  describe 'relationships' do
    it { should have_many :dish_foods }
    it { should have_many(:dishes).through(:dish_foods) }

    it { should have_many :food_ingredients }
    it { should have_many(:ingredients).through(:food_ingredients) }
  end

  describe 'instance methods' do
    it "can format its ingredients into an array" do
      food = create(:food)
      food_info = {
            "fdcId": 631954,
            "description": "CLASSICO, TOMATO & BASIL PASTA SAUCE, TOMATO & BASIL, TOMATO & BASIL",
            "dataType": "Branded",
            "gtinUpc": "041129077122",
            "publishedDate": "2019-12-06",
            "brandOwner": "New World Pasta Company",
            "ingredients": "TOMATO PUREE (WATER, TOMATO PASTE), DICED TOMATOES IN JUICE (TOMATOES, TOMATO JUICE, CITRIC ACID, CALCIUM CHLORIDE), CONTAINS 2% OR LESS OF: OLIVE OIL, ONIONS, SALT, BASIL, GARLIC, SPICES, NATURAL FLAVOR.",
            "allHighlightFields": "<b>GTIN/UPC</b>: <em>041129077122</em>",
            "score": -747.62915
        }
      expect(food.ingredient_list(food_info)).to eq( ["TOMATO PUREE", "DICED TOMATOES IN JUICE"] )
    end

    it "can create ingredients" do
      food = create(:food)
      food_info = {
            "fdcId": 631954,
            "description": "CLASSICO, TOMATO & BASIL PASTA SAUCE, TOMATO & BASIL, TOMATO & BASIL",
            "dataType": "Branded",
            "gtinUpc": "041129077122",
            "publishedDate": "2019-12-06",
            "brandOwner": "New World Pasta Company",
            "ingredients": "TOMATO PUREE (WATER, TOMATO PASTE), DICED TOMATOES IN JUICE (TOMATOES, TOMATO JUICE, CITRIC ACID, CALCIUM CHLORIDE), CONTAINS 2% OR LESS OF: OLIVE OIL, ONIONS, SALT, BASIL, GARLIC, SPICES, NATURAL FLAVOR.",
            "allHighlightFields": "<b>GTIN/UPC</b>: <em>041129077122</em>",
            "score": -747.62915
        }

        food.create_ingredients(food_info)
        expect(food.ingredients.pluck(:name)).to eq( ["TOMATO PUREE", "DICED TOMATOES IN JUICE"] )
    end
  end
end
