require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :gut_feeling }

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
end
