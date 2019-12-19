require 'rails_helper'

RSpec.describe FoodIngredient, type: :model do
  describe 'relationships' do
    it { should belong_to :food }
    it { should belong_to :ingredient }
  end
end
