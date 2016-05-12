json.array! @pending_pages.each do |page|
  json.longUrl page.long_url
end