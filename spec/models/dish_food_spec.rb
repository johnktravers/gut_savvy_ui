require 'rails_helper'

RSpec.describe DishFood, type: :model do
  describe 'relationships' do
    it { should belong_to :dish }
    it { should belong_to :food }
  end
end
