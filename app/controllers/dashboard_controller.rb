class DashboardController < ApplicationController
  def show
    unless current_user.twitter_handle
      user_twitter_handle = current_user.client.user.screen_name
      current_user.update(twitter_handle: user_twitter_handle)
    end
  end
end
