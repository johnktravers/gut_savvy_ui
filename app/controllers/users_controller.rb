class UsersController < ApplicationController
  def new; end

  def show
    @meals = current_user.meals
  end
end
