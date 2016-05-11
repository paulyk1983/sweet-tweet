class Api::V1::PagesController < ApplicationController
  def index
    @pages = Page.all
    render 'index.json.jbuilder'
  end 

  def show
  end

  def create
    if current_user
      @page = Page.new(
        long_url: params[:url]
      )
      if @page.save
        # render 'show.json.jbuilder'
        render 'success.html.erb', :layout => false
      else
        render json: { errors: @page.errors.full_messages }, status: 422
      end     
    else
      redirect_to '/'
    end  
  end 
end