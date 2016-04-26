json.array! @tweets.each do |tweet|
  json.text tweet.text
  json.retweet_count tweet.retweet_count
  json.url tweet.url
end

