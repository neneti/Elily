# frozen_string_literal: true

class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: %i[index edit update destroy following followers]
  before_action :correct_user,   only: %i[edit update]

  def index
    @q = User.ransack(params[:q])
    if params[:all_user].present?
      @users = User.recent.page(params[:page])
    else
      @users = @q.result(distinct: true).recent.page(params[:page])
      flash.now[:info] = '該当するユーザーが見つかりませんでした。' if @users.empty?
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
    @microposts_cards = @user.microposts.recent_count(3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = '登録を完了するには、メールを確認してください。'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールを更新しました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'アカウントを削除しました。'
    redirect_to root_url
  end

  def following
    @title = 'フォロー'
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def posts
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile,
                                 :avatar, :password,
                                 :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
