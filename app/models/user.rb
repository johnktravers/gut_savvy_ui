class User < ApplicationRecord
  validates_presence_of :name, :email, :token, :uid
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  has_many :meals

  has_many :meal_dishes, through: :meals
  has_many :dishes, through: :meal_dishes

  has_many :meal_ingredients, through: :meals
  has_many :ingredients, through: :meal_ingredients
end
