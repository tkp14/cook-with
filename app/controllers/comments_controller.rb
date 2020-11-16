class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:id])
    @user = @dish.user
    @comment = @dish.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@dish.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def delete
  end
end
