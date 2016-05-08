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

  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
  end

  def tweet(tweet)
    client.update(tweet)
  end

  def user_tweets
    options = {count: 50, include_rts: true}
    client.user_timeline(client.user.screen_name, options)
  end

  def past_six_months
    months = []
    6.times do |i|
      months << (Date.today - i.month).strftime('%b').to_s
    end
    months.reverse!
  end

  def past_year
    months = []
    12.times do |i|
      months << (Date.today - i.month).strftime('%b').to_s
    end
    months.reverse!
  end

  def retweet_chart
    options = {count: 200, include_rts: true}
    tweets = client.user_timeline(client.user.screen_name, options)

    months = {}
    6.times do |i|
      months[past_six_months[i]] = 0
    end

    day_of_month = Time.zone.today.strftime('%e').to_i
    chart_start_date = Time.zone.today - 5.month - day_of_month
    
    tweets.each do |tweet| 
      if tweet.created_at > chart_start_date
        count = tweet.retweet_count
        tweet_month = tweet.created_at.strftime('%b')
        old_total = months[tweet_month]
        new_total = count + old_total
        months[tweet_month] = new_total
      end
    end  
    months.values
  end

  def retweet_chart_past_year
    options = {count: 200, include_rts: true}
    tweets = client.user_timeline(client.user.screen_name, options)

    months = {}
    6.times do |i|
      months[past_year[i]] = 0
    end

    day_of_month = Time.zone.today.strftime('%e').to_i
    chart_start_date = Time.zone.today - 12.month - day_of_month
    
    tweets.each do |tweet| 
      if tweet.created_at > chart_start_date
        count = tweet.retweet_count
        tweet_month = tweet.created_at.strftime('%b')
        old_total = months[tweet_month]
        new_total = count + old_total
        months[tweet_month] = new_total
      end
    end  
    months.values
  end

  def test
    1
  end
  
end
