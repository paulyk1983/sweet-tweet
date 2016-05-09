class Api::V1::PagesController < ApplicationController
  def index
    if current_user
      @page = current_user.submit_url
      render 'index.json.jbuilder'     
    else
      redirect_to '/'
    end  
  end 
end