class Api::V1::TweetsController < ApplicationController
  def index
    if current_user
      @tweets = current_user.user_tweets
      render 'index.json.jbuilder'     
    else
      redirect_to '/'
    end  
  end 
end