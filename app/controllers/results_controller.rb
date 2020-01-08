class ResultsController < ApplicationController
  def index
    @ingredients = current_user.ingredients
  end
end
