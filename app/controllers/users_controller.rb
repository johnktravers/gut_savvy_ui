class UsersController < ApplicationController
  before_action :require_login, only: :show

  def new; end

  def show
    @meals = current_user.meals
  end
end
