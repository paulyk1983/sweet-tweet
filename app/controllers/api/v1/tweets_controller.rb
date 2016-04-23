class Api::V1::TweetsController < ApplicationController
  def index
    @tweets = current_user.user_tweets
    render 'index.json.jbuilder'
  end 
end