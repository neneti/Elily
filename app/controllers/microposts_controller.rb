class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    if params[:tag_name]
      @microposts = Micropost.tagged_with("#{params[:tag_name]}").recent.page(params[:page])
    else
      @q = Micropost.ransack(params[:q])
      @microposts = @q.result(distinct: true).recent.page(params[:page])
      if @microposts.empty?
        flash.now[:notice] = '該当するイラストが見つかりませんでした。'
      end
    end
  end

  def show
    @micropost = Micropost.includes(:user).find(params[:id])
    @user = @micropost.user
    @comments = @micropost.comments.includes(:user).all
    @comment = @micropost.comments.build(user_id: current_user.id) if current_user
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿が完了しました。"
      redirect_to @micropost
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to request.referrer || root_url
  end

private

  def micropost_params
    params.require(:micropost).permit(:content, :start_time,
                                      :created_at_gteq,:title,
                                      :illusts,:tag_list,:title_cont)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
