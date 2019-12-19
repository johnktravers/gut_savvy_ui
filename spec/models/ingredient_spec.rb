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
end
