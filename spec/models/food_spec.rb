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
end
