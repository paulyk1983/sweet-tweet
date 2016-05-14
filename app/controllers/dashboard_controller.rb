class DashboardController < ApplicationController
  def show
    if !current_user.twitter_handle
      @test = 'no twitter handle'
    else
      @test = 'test'
    end
  end
end
