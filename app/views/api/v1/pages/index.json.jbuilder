json.array! @pages.each do |page|
  json.longUrl page.long_url
end