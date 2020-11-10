class DishesController < ApplicationController
  before_action :logged_in_user

  def new
    @dish = Dish.new
  end
end
