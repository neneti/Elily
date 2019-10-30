class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      @micropost.create_notification_comment!(current_user, @comment.id)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

end
