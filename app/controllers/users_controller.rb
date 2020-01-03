class UsersController < ApplicationController
  before_action :require_login, only: :show
  
  def new; end

  def show; end
end
