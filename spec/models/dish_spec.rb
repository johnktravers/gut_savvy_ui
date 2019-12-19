require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'relationships' do
    it { should have_many :meal_dishes }
    it { should have_many(:meals).through(:meal_dishes) }

    it { should have_many :dish_foods }
    it { should have_many(:foods).through(:dish_foods) }
  end
end
