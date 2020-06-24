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

        @ingredient_1 = create(:ingredient)  # avg: -4.0
        @ingredient_2 = create(:ingredient)  # avg: -1.0
        @ingredient_3 = create(:ingredient)  # avg: -3.67
        @ingredient_4 = create(:ingredient)  # avg: -0.67
        @ingredient_5 = create(:ingredient)  # avg: -0.25
        @ingredient_6 = create(:ingredient)  # avg: -1.33
        @ingredient_7 = create(:ingredient)  # avg: +2.5
        @ingredient_8 = create(:ingredient)  # avg: +0.25
        @ingredient_9 = create(:ingredient)  # avg: +2.0
        @ingredient_10 = create(:ingredient) # avg: +3.67
        @ingredient_11 = create(:ingredient) # avg: +1.33
        @ingredient_12 = create(:ingredient) # avg: +3.5

        @meal_1.ingredients.push(@ingredient_1, @ingredient_3, @ingredient_11)
        @meal_2.ingredients.push(@ingredient_1, @ingredient_3, @ingredient_8)
        @meal_3.ingredients.push(@ingredient_1, @ingredient_2, @ingredient_6)
        @meal_4.ingredients.push(@ingredient_4, @ingredient_5, @ingredient_3)
        @meal_5.ingredients.push(@ingredient_4, @ingredient_5, @ingredient_6)
        @meal_6.ingredients.push(@ingredient_8, @ingredient_5, @ingredient_6)
        @meal_7.ingredients.push(@ingredient_4, @ingredient_9, @ingredient_2)
        @meal_8.ingredients.push(@ingredient_8, @ingredient_9, @ingredient_5)
        @meal_9.ingredients.push(@ingredient_7, @ingredient_8, @ingredient_9)
        @meal_10.ingredients.push(@ingredient_10, @ingredient_11)
        @meal_11.ingredients.push(@ingredient_10, @ingredient_11, @ingredient_12)
        @meal_12.ingredients.push(@ingredient_10, @ingredient_12, @ingredient_7)
      end

      it 'sorted_ingredients' do
        worst_result = @user.sorted_ingredients('worst', 6)

        expect(worst_result.length).to eq(6)
        expect(worst_result.first.avg_gut_feeling).to eq(-4)
        expect(worst_result.last.avg_gut_feeling).to eq(-0.25)
        expect(worst_result.first.name).to eq(@ingredient_1.name)
        expect(worst_result.last.name).to eq(@ingredient_5.name)

        best_result = @user.sorted_ingredients('best', 5)

        expect(best_result.length).to eq(5)
        expect(best_result.first.avg_gut_feeling.round(2)).to eq(3.67)
        expect(best_result.last.avg_gut_feeling.round(2)).to eq(1.33)
        expect(best_result.first.name).to eq(@ingredient_10.name)
        expect(best_result.last.name).to eq(@ingredient_11.name)
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
