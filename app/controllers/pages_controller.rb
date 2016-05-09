require 'unirest'
class PagesController < ApplicationController
  def index
    @short_url = Unirest.post("https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyBeeWRP3FAqheQSVRMDTnzjZvVbNVht7GI",
      headers: { "Content-Type" => "application/json" },
      parameters: {"longUrl" => "https://www.google.com"}
    ).body
  end

  def show
  end

  def new
  end

  def create
  end
end
