require 'unirest'

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
    Page.create(
      long_url: params[:long_url],
      short_url: short_url,
      title: title
    )
    redirect_to '/tweets/new'
  end
end
