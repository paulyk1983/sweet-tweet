require 'unirest'
require 'open-uri'

class PagesController < ApplicationController
  def index
    # page = MetaInspector.new('https://finishlinecorp.com')
    # @data = page.title
    @pages = Page.where("status = ? AND user_id = ?", 'pending', current_user.id)
  end

  def new
    render 'index.html.erb'
  end

  def create
    response = Unirest.post(
      "https://www.googleapis.com/urlshortener/v1/url?key=#{ENV['SHORTENER_KEY']}",
      headers: {"Accept" => "application/json", "Content-Type" => "application/json"},
      parameters: {'longUrl' => params[:long_url]}.to_json
    )
    data = response.body
    short_url = data["id"]  

    if response.code != 200
      flash[:danger] = "Something went wrong on the web -> Error code: #{response.code}. Sorry for the inconvenience"
      redirect_to "/pages"
    else  

      # page = MetaInspector.new(params[:long_url])
      # above code will generate this error if faraday options are not set: SSL_connect returned=1 errno=0 state=error: certificate verify failed
      page = MetaInspector.new(params[:long_url], faraday_options: { ssl: { verify: false } })

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
        image: image,
        status: 'pending',
        user_id: current_user.id
      )
      page_id = Page.last.id
      redirect_to "/pages"
    end
  end

  def update    

    response = Unirest.post(
      "https://www.googleapis.com/urlshortener/v1/url?key=#{ENV['SHORTENER_KEY']}",
      headers: {"Accept" => "application/json", "Content-Type" => "application/json"},
      parameters: {'longUrl' => params[:long_url]}.to_json
    )
    data = response.body
    short_url = data["id"]

    if response.code != 200
      flash[:danger] = "Something went wrong on the web -> Error code: #{response.code}. Sorry for the inconvenience"
      redirect_to "/pages"
    else
      # page = MetaInspector.new(params[:long_url])
      # above code will generate this error if faraday options are not set: SSL_connect returned=1 errno=0 state=error: certificate verify failed
      page = MetaInspector.new(params[:long_url], faraday_options: { ssl: { verify: false } })
      
      title = page.title
      image = page.images.best
      open(image) { |f|
        File.open("tweet_image.jpg", "wb") do |file|
          file.puts f.read
        end
      }

      page = Page.find_by(id: params[:id])
      page.update(
        long_url: params[:long_url],
        short_url: short_url,
        title: title,
        image: image
      )
      redirect_to "/tweets/new?id=#{page.id}"
    end

  end

  def delete
    page = Page.find_by(id: params[:id])
    page.delete
    if page.save
      flash[:success] = "The saved page has been removed"
      redirect_to "/pages"
    else
      flash[:danger] = "Something went wrong. Could not delete that page"
      redirect_to "/pages"
    end
  end
end
