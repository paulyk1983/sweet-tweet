require 'unirest'

class PagesController < ApplicationController
  def index
    
  end

  def new
    @short_url = Unirest.post("https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyBeeWRP3FAqheQSVRMDTnzjZvVbNVht7GI",
      headers: { "Content-Type" => "application/json" },
      parameters: {"longUrl" => "https://www.google.com"}
    ).body
    url = params["long_url"]
    @page = current_user.submit_url(url)
    render 'index.html.erb'
  end

  def create
  end
end
