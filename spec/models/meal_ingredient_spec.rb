require 'rails_helper'

RSpec.describe MealIngredient, type: :model do
  describe 'relationships' do
    it { should belong_to :meal }
    it { should belong_to :ingredient }
  end
end
