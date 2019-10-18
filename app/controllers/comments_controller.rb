class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    comment = @micropost.comments.build(comment_params)
    comment.user = current_user
    if comment.save
      flash[:success] = 'コメントしました。'
      redirect_back(fallback_location: micropost_path(@micropost))
    else
      flash[:alert] = 'コメント入力に誤りがあります。'
      redirect_back(fallback_location: micropost_path(@micropost))
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    @micropost = Micropost.find(comment.micropost_id)
    comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: micropost_path(@micropost))
  end

  private

  def comment_params
    params.permit(:content)
  end
end
