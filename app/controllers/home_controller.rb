class HomeController < ApplicationController
  def show
    if current_user
      redirect_to '/pages'
    end
  end
end
