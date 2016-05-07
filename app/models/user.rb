

class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end

  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    
    client.update(tweet)
  end

  def user_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    options = {count: 50, include_rts: true}
    client.user_timeline(client.user.screen_name, options)
  end

  def retweet_chart
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    options = {count: 200, include_rts: true}
    tweets = client.user_timeline(client.user.screen_name, options)
    retweets = 0
    jan = 0
    feb = 0
    mar = 0
    apr = 0
    may = 0
    jun = 0
    tweets.each do |tweet| 
      if tweet.created_at.strftime('%m') == '01'
        jan += tweet.retweet_count
      elsif tweet.created_at.strftime('%m') == '02'
        feb += tweet.retweet_count
      elsif tweet.created_at.strftime('%m') == '03'
        mar += tweet.retweet_count
      elsif tweet.created_at.strftime('%m') == '04'
        apr += tweet.retweet_count
      elsif tweet.created_at.strftime('%m') == '05'
        may += tweet.retweet_count
      elsif tweet.created_at.strftime('%m') == '06'
        jun += tweet.retweet_count
      end
    end  
    [jan, feb, mar, apr, may, jun]
  end
end
