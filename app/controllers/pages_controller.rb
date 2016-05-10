require 'unirest'

class PagesController < ApplicationController
  def index
  end

  def new
    render 'index.html.erb'
  end

  def create
    data = Unirest.post(
      "https://www.googleapis.com/urlshortener/v1/url?key=#{ENV['SHORTENER_KEY']}",
      headers: {"Accept" => "application/json", "Content-Type" => "application/json"},
      parameters: {'longUrl' => 'http://google.com'}.to_json
    ).body
    short_url = data["id"]
    Page.create(
      long_url: params[:long_url],
      short_url: short_url
    )
    redirect_to '/tweets/new'
  end
end
