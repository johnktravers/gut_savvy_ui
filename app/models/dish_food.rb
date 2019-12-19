class DishFood < ApplicationRecord
  belongs_to :dish
  belongs_to :food
end
