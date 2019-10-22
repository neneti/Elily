class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.recent.page(params[:page])
    @user_ranking = User.user_month_ranks

    if logged_in?
      @user = current_user
      @microposts = current_user.feed.page(params[:page])
      @all_microposts = Micropost.recent.page(params[:page])
      @week_ranking = Micropost.week_ranks
    end
  end
end
