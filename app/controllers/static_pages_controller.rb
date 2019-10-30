class StaticPagesController < ApplicationController
  def home
    @micropost_new = Micropost.recent_count(5)
    @micropost_ranking = Micropost.week_ranks
    @users = User.user_pickup
    @tag = ActsAsTaggableOn::Tag.most_used(10)
    if logged_in?
      @user = current_user
      @feed_microposts = @user.feed.recent_count(5)
    end
  end
end
