

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

  def past_six_months
    month1 = (Date.today - 5.month).strftime('%b').to_s
    month2 = (Date.today - 4.month).strftime('%b').to_s
    month3 = (Date.today - 3.month).strftime('%b').to_s
    month4 = (Date.today - 2.month).strftime('%b').to_s
    month5 = (Date.today - 1.month).strftime('%b').to_s
    month6 = Date.today.strftime('%b').to_s
    [month1, month2, month3, month4, month5, month6]
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
    month1 = 0
    month2 = 0
    month3 = 0
    month4 = 0
    month5 = 0
    month6 = 0
    tweets.each do |tweet| 
      if tweet.created_at.strftime('%b') == past_six_months[0]
        month1 += tweet.retweet_count
      elsif tweet.created_at.strftime('%b') == past_six_months[1]
        month2 += tweet.retweet_count
      elsif tweet.created_at.strftime('%b') == past_six_months[2]
        month3 += tweet.retweet_count
      elsif tweet.created_at.strftime('%b') == past_six_months[3]
        month4 += tweet.retweet_count
      elsif tweet.created_at.strftime('%b') == past_six_months[4]
        month5 += tweet.retweet_count
      elsif tweet.created_at.strftime('%b') == past_six_months[5]
        month6 += tweet.retweet_count
      end
    end  
    [month1, month2, month3, month4, month5, month6]
  end

  def test
    past_six_months
  end
    
end
