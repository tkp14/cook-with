class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:dish_id])
    @user = @dish.user
    @comment = @dish.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@dish.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
      # 自分以外のユーザーからコメントがあったときのみ通知を作成
      if @user != current_user
        @user.notifications.create(dish_id: @dish.id, variety: 2,
                                 from_user_id: current_user.id,
                                 content: @comment.content)
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @dish = @comment.dish
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to dish_url(@dish)
  end
end
