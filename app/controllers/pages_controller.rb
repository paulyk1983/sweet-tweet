require 'unirest'
require 'open-uri'

class PagesController < ApplicationController
  def index
    page = MetaInspector.new('https://finishlinecorp.com')
    @data = page.title
  end

  def new
    render 'index.html.erb'
  end

  def create
    data = Unirest.post(
      "https://www.googleapis.com/urlshortener/v1/url?key=#{ENV['SHORTENER_KEY']}",
      headers: {"Accept" => "application/json", "Content-Type" => "application/json"},
      parameters: {'longUrl' => params[:long_url]}.to_json
    ).body
    short_url = data["id"]
    page = MetaInspector.new(params[:long_url])
    title = page.title
    image = page.images.best
    open(image) { |f|
      File.open("tweet_image.jpg", "wb") do |file|
        file.puts f.read
      end
    }   
    
    Page.create(
      long_url: params[:long_url],
      short_url: short_url,
      title: title,
      image: image
    )
    redirect_to '/tweets/new'
  end
end
