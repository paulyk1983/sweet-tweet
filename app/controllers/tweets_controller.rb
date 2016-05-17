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
    if params[:image] == 'true'
      current_user.tweet_with_image(twitter_params[:message], page.image)
    else
      current_user.tweet(twitter_params[:message])
    end    
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
