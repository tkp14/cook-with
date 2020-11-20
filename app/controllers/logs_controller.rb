class LogsController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:dish_id])
    @log = @dish.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "ログを追加しました！"
    redirect_to dish_path(@dish)
  end

  def destroy
    @log = Log.find(params[:id])
    @dish = @log.dish
    if current_user == @dish.user
      @log.destroy
      flash[:success] = "ログを削除しました！"
    end
    redirect_to dish_url(@dish)
  end
end
