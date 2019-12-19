require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :token }
    it { should validate_presence_of :uid }

    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('user.example.com').for(:email) }

    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :uid }
  end

  describe 'relationships' do
    it { should have_many :meals }

    it { should have_many(:meal_dishes).through(:meals) }
    it { should have_many(:dishes).through(:meal_dishes) }

    it { should have_many(:meal_ingredients).through(:meals) }
    it { should have_many(:ingredients).through(:meal_ingredients) }
  end
end
