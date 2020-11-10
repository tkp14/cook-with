class DishesController < ApplicationController
  before_action :logged_in_user

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.find(params[:id])
    if @dish.save
      flash[:success] = "料理が登録されました！"
      redirect_to root_url
    else
      render "dishes/new"
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :discription, :portion, :tips,
                                 :reference, :required_time, :popularity, :cook_memo)
  end
end
