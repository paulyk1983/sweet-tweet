class TweetsController < ApplicationController
  attr_accessor :image, :page

  def index
  end

  def new
    page = Page.find_by(id: params[:id])
    if page
      @message = page.title + ' ' + page.short_url
      @image = page.image
      @page_id = page.id 
    else
      @message = ''
      @image = ''
      @page_id = 0
    end
    
  end

  def create
    page = Page.find_by(id: params[:page_id])
    if page
      page.update(status: 'sent')
    end 
    current_user.tweet(twitter_params[:message], @image)
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
