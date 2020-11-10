class DishesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def new
    @dish = Dish.new
  end

  def show
    @dish = Dish.find(params[:id])
  end

  def create
    @dish = current_user.dishes.build(dish_params)
    if @dish.save
      flash[:success] = "料理が登録されました！"
      redirect_to dish_path(@dish)
    else
      render "dishes/new"
    end
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(dish_params)
      flash[:success] = "料理情報が更新されました！"
      redirect_to @dish
    else
      redirect_to 'edit'
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :discription, :portion, :tips,
                                 :reference, :required_time, :popularity, :cook_memo)
  end

  def correct_user
    # 現在のユーザーが更新対象の料理を保有しているかどうか確認
    @dish = current_user.dishes.find_by(id: params[:id])
    redirect_to root_url if @dish.nil?
  end
end
