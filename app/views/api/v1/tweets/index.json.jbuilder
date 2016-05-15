json.array! @tweets.each do |tweet|
  json.id tweet.id
  json.text tweet.text
  json.created_at tweet.created_at
  json.retweet_count tweet.retweet_count
  json.favorites_count tweet.favorites_count
  json.rank (tweet.retweet_count * 2) + tweet.favorites_count
  json.media tweet.media
end
