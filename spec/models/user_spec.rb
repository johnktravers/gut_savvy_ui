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
    it { should validate_uniqueness_of(:uid).case_insensitive }
  end

  describe 'relationships' do
    it { should have_many :meals }

    it { should have_many(:meal_dishes).through(:meals) }
    it { should have_many(:dishes).through(:meal_dishes) }

    it { should have_many(:meal_ingredients).through(:meals) }
    it { should have_many(:ingredients).through(:meal_ingredients) }

    it { should have_many(:dish_foods).through(:dishes) }
    it { should have_many(:foods).through(:dish_foods) }
  end

  describe 'instance_methods' do
    it 'ratings_needed' do
      user = create(:user)
      expect(user.ratings_needed).to eq(12)

      create_list(:unrated_meal, 5, user: user)
      expect(user.ratings_needed).to eq(12)

      create_list(:meal, 5, user: user)
      expect(user.ratings_needed).to eq(7)

      create_list(:meal, 8, user: user)
      expect(user.ratings_needed).to eq(-1)
    end

    describe 'ingredient analysis' do
      before(:each) do
        Faker::UniqueGenerator.clear # Clears used values for all generators
        Ingredient.destroy_all

        @user = create(:user)
        @meal_1 = create(:meal, user: @user, gut_feeling: -5, created_at: 'Sat, 21 Dec 2019 14:54:09 UTC +00:00')
        @meal_2 = create(:meal, user: @user, gut_feeling: -4, created_at: 'Sat, 21 Dec 2019 14:54:09 UTC +00:00')
        @meal_3 = create(:meal, user: @user, gut_feeling: -3, created_at: 'Sat, 21 Dec 2019 14:54:09 UTC +00:00')
        @meal_4 = create(:meal, user: @user, gut_feeling: -2, created_at: 'Sun, 22 Dec 2019 14:54:09 UTC +00:00')
        @meal_5 = create(:meal, user: @user, gut_feeling: -1, created_at: 'Sun, 22 Dec 2019 14:54:09 UTC +00:00')
        @meal_6 = create(:meal, user: @user, gut_feeling: 0, created_at: 'Sun, 22 Dec 2019 14:54:09 UTC +00:00')
        @meal_7 = create(:meal, user: @user, gut_feeling: 1, created_at: 'Mon, 23 Dec 2019 14:54:09 UTC +00:00')
        @meal_8 = create(:meal, user: @user, gut_feeling: 2, created_at: 'Mon, 23 Dec 2019 14:54:09 UTC +00:00')
        @meal_9 = create(:meal, user: @user, gut_feeling: 3, created_at: 'Mon, 23 Dec 2019 14:54:09 UTC +00:00')
        @meal_10 = create(:meal, user: @user, gut_feeling: 4, created_at: 'Tue, 24 Dec 2019 14:54:09 UTC +00:00')
        @meal_11 = create(:meal, user: @user, gut_feeling: 5, created_at: 'Tue, 24 Dec 2019 14:54:09 UTC +00:00')
        @meal_12 = create(:meal, user: @user, gut_feeling: 2, created_at: 'Tue, 24 Dec 2019 14:54:09 UTC +00:00')

        create(:meal_ingredient, meal: @meal_1)
        create(:meal_ingredient, meal: @meal_2)
        create(:meal_ingredient, meal: @meal_3)
        create(:meal_ingredient, meal: @meal_4)
        create(:meal_ingredient, meal: @meal_5)
        create(:meal_ingredient, meal: @meal_6)
        create(:meal_ingredient, meal: @meal_7)
        create(:meal_ingredient, meal: @meal_8)
        create(:meal_ingredient, meal: @meal_9)
        create(:meal_ingredient, meal: @meal_10)
        create(:meal_ingredient, meal: @meal_11)
        create(:meal_ingredient, meal: @meal_12)
      end

      it 'best_ingredients' do
        result = @user.best_ingredients

        expect(result.length).to eq(6)
        expect(result.first.avg_gut_feeling).to eq(5)
        expect(result.last.avg_gut_feeling).to eq(1)
      end

      it 'best_ingredients_data' do
        result = @user.best_ingredients_data

        expect(result.count).to eq(6)
        expect(result.first.keys).to eq(%i[name avg_gut_feeling])
      end

      it 'worst_ingredients' do
        result = @user.worst_ingredients

        expect(result.length).to eq(5)
        expect(result.first.avg_gut_feeling).to eq(-5)
        expect(result.last.avg_gut_feeling).to eq(-1)
      end

      it 'worst_ingredients_data' do
        result = @user.worst_ingredients_data

        expect(result.count).to eq(5)
        expect(result.first.keys).to eq(%i[name avg_gut_feeling])
      end

      it 'gut_feelings_over_time' do
        result = @user.gut_feelings_over_time.sort_by do |gut_feeling_hash|
          gut_feeling_hash[:date]
        end

        expect(result.count).to eq(4)
        expect(result[0][:avg_gut_feeling]).to eq(-0.4e1)
        expect(result[0][:date]).to eq(@meal_1.created_at.to_date)
      end
    end
  end
end
