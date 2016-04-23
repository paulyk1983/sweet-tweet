class TweetsController < ApplicationController
  def index
    @timeline = current_user.user_tweets
  end

  def new
  end

  def create
    current_user.tweet(twitter_params[:message])
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
