# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create edit update destroy]
  before_action :correct_user,   only: %i[edit update destroy]

  def index
    if params[:tag_name]
      @microposts = Micropost.tagged_with(params[:tag_name].to_s).recent.page(params[:page])
      @tag = ActsAsTaggableOn::Tag.most_used(10)
    else
      @q = Micropost.ransack(params[:q])
      @microposts = @q.result(distinct: true).recent.page(params[:page]).per(15)
      flash.now[:warning] = '該当するイラストが見つかりませんでした。' if @microposts.empty?
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
      flash[:success] = '投稿が完了しました。'
      redirect_to @micropost
    else
      @feed_items = []
      render :new
    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    if @micropost.update_attributes(micropost_params)
      redirect_to micropost_path(@micropost), notice: '投稿を更新しました。'
    else
      flash.now[:alert] = '入力に誤りがあります。'
      render :edit
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to root_url
  end

  def following
    @user = current_user
    @microposts = @user.feed.recent.page(params[:page]).per(15)
  end

  def ranking
    @microposts_week_ranking = Micropost.main_week_ranks
    @microposts_month_ranking = Micropost.main_month_ranks
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :start_time,
                                      :created_at_gteq, :title,
                                      :illusts, :tag_list, :title_cont)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
