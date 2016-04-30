class DashboardController < ApplicationController
  def show
    @timeline = current_user.user_tweets
  end
end
