require 'rails_helper'

RSpec.describe MealDish, type: :model do
  describe 'relationships' do
    it { should belong_to :meal }
    it { should belong_to :dish }
  end
end
