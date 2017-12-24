class User < ActiveRecord::Base
  has_many :pages
  has_many :tweets
  has_many :mentions
  has_many :followers
  
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

  def tweet_with_image(tweet, file)
    client.update_with_media(
      tweet, 
      open("tweet_image.jpg")
    )   
  end

  def delete_tweet_image
    File.delete("tweet_image.jpg")
  end

  def tweet(tweet)
    client.update(tweet)
  end

  def user_tweets
    options = {count: 50, include_rts: true}
    client.user_timeline(current_user.twitter_handle, options)
  end

  def past_day(event_type, events)
    today = Time.zone.today.to_s
    events_today = 0
    events.each do |event|
      if event.created_at.strftime('%Y-%m-%d') == today.to_s
        if event_type == 'retweets'
          events_today += event.retweet_count
        elsif event_type == 'favorites'
          events_today += event.favorites_count
        else
          events_today += 1
        end
      end
    end
    events_today
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

  def chart(number_of_months, event_type, events)    
    months = {}
    number_of_months.times do |i|
      if number_of_months == 6
        months[past_six_months[i]] = 0
      else
        months[past_year[i]] = 0
      end
    end

    day_of_month = Date.today.strftime('%e').to_i
    chart_start_date = Date.today - (number_of_months - 1).month - day_of_month

    events.each do |event|
      if event.tweet_time > chart_start_date
        event_month = event.tweet_time.strftime('%b')
        if event_type == 'retweets'
          count = event.retweets_count           
        elsif event_type == 'favorites'
          count = event.favorites_count   
        else
          count = 1
        end
        old_total = months[event_month]
        new_total = count + old_total
        months[event_month] = new_total
      end
    end
    months.values
  end

  def chart_mentions(number_of_months, mentions)    
    months = {}
    number_of_months.times do |i|
      if number_of_months == 6
        months[past_six_months[i]] = 0
      else
        months[past_year[i]] = 0
      end
    end

    day_of_month = Time.zone.today.strftime('%e').to_i
    chart_start_date = Time.zone.today - (number_of_months - 1).month - day_of_month
    
    mentions.each do |mention|
      if mention.mention_time > chart_start_date
        mention_month = mention.mention_time.strftime('%b')
        old_total = months[mention_month]
        new_total = old_total + 1
        months[mention_month] = new_total
      end
    end
    months.values
  end
end
