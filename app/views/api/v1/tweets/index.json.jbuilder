json.array! @tweets.each do |tweet|
  json.text tweet.text
  json.created_at tweet.created_at
  json.retweet_count tweet.retweet_count
  json.favorites_count tweet.favorites_count
  json.media tweet.media
end
