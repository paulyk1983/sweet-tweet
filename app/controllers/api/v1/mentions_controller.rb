class Api::V1::MentionsController < ApplicationController
  def index
    if current_user
      @mentions = current_user.user_mentions
      render 'index.json.jbuilder'     
    else
      redirect_to '/'
    end  
  end 
end