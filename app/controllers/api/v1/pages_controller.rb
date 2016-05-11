class Api::V1::PagesController < ApplicationController
  def index
    @pending_pages = Page.where("status = ? AND user_id = ?", 'pending', current_user.id)
    render 'index.json.jbuilder'
  end 

  def show
  end

  def create
    if current_user
      @page = Page.new(
        long_url: params[:url],
        status: 'pending',
        user_id: current_user.id
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