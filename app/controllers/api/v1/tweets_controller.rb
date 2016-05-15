class Api::V1::TweetsController < ApplicationController
  def index
    if current_user
      options = {count: 100, include_rts: true}
      @tweets = current_user.client.user_timeline(current_user.twitter_handle, options)
      render 'index.json.jbuilder'     
    else
      redirect_to '/'
    end  
  end 
end