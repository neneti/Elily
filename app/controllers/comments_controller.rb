class CommentsController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      @micropost.create_notification_comment!(current_user, @comment.id)
      flash[:success] = "コメントをしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:created_at)
  end

end
