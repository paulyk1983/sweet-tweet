class User < ActiveRecord::Base
  has_many :pages
  
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

  def tweet(tweet, image)
    if image
      client.update_with_media(
        tweet, 
        open("tweet_image.jpg")
      )
      File.delete("tweet_image.jpg")
    else
      client.update(tweet)
    end
  end

  def user_tweets
    options = {count: 50, include_rts: true}
    client.user_timeline(client.user.screen_name, options)
  end

  def user_mentions
    client.mentions_timeline
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

  def chart(time_frame, event_type)
    options = {count: 200, include_rts: true}
    if event_type == 'mentions'
      events = client.mentions_timeline(options)
    else
      events = client.user_timeline(client.user.screen_name, options)
    end
    
    months = {}
    6.times do |i|
      if time_frame == 6
        months[past_six_months[i]] = 0
      else
        months[past_year[i]] = 0
      end
    end

    day_of_month = Time.zone.today.strftime('%e').to_i
    if time_frame == 6
      time_frame = 5
    end
    chart_start_date = Time.zone.today - time_frame.month - day_of_month
    
    events.each do |event| 
      if event.created_at > chart_start_date
        event_month = event.created_at.strftime('%b')
        if event_type == 'retweets'
          count = event.retweet_count           
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

   # def retweet_chart(time_frame)
  #   options = {count: 200, include_rts: true}
  #   tweets = client.user_timeline(client.user.screen_name, options)

  #   months = {}
  #   time_frame.times do |i|
  #     if time_frame == 6
  #       months[past_six_months[i]] = 0
  #     else
  #       months[past_year[i]] = 0
  #     end  
  #   end

  #   day_of_month = Time.zone.today.strftime('%e').to_i
  #   if time_frame == 6
  #     time_frame = 5
  #   end
  #   chart_start_date = Time.zone.today - time_frame.month - day_of_month
    
  #   tweets.each do |tweet| 
  #     if tweet.created_at > chart_start_date
  #       tweet_month = tweet.created_at.strftime('%b')
  #       count = tweet.retweet_count        
  #       old_total = months[tweet_month]
  #       new_total = count + old_total
  #       months[tweet_month] = new_total
  #     end
  #   end  
  #   months.values
  # end

  # def favorites_chart(time_frame)
  #   options = {count: 200, include_rts: true}
  #   tweets = client.user_timeline(client.user.screen_name, options)

  #   months = {}
  #   time_frame.times do |i|
  #     if time_frame == 6
  #       months[past_six_months[i]] = 0
  #     else
  #       months[past_year[i]] = 0
  #     end
  #   end

  #   day_of_month = Time.zone.today.strftime('%e').to_i
  #   if time_frame == 6
  #     time_frame = 5
  #   end
  #   chart_start_date = Time.zone.today - time_frame.month - day_of_month
    
  #   tweets.each do |tweet| 
  #     if tweet.created_at > chart_start_date        
  #       tweet_month = tweet.created_at.strftime('%b')
  #       count = tweet.favorites_count
  #       old_total = months[tweet_month]
  #       new_total = count + old_total
  #       months[tweet_month] = new_total
  #     end
  #   end  
  #   months.values
  # end

  # def mentions_chart(time_frame)
  #   options = {count: 200, include_rts: true}
  #   mentions = client.mentions_timeline(options)

  #   months = {}
  #   6.times do |i|
  #     if time_frame == 6
  #       months[past_six_months[i]] = 0
  #     else
  #       months[past_year[i]] = 0
  #     end
  #   end

  #   day_of_month = Time.zone.today.strftime('%e').to_i
  #   if time_frame == 6
  #     time_frame = 5
  #   end
  #   chart_start_date = Time.zone.today - time_frame.month - day_of_month
    
  #   mentions.each do |mention| 
  #     if mention.created_at > chart_start_date
  #       mention_month = mention.created_at.strftime('%b')
  #       old_total = months[mention_month]
  #       new_total = old_total + 1
  #       months[mention_month] = new_total
  #     end
  #   end  
  #   months.values
  # end

  # def favorites_chart_past_year
  #   options = {count: 200, include_rts: true}
  #   tweets = client.user_timeline(client.user.screen_name, options)

  #   months = {}
  #   12.times do |i|
  #     months[past_year[i]] = 0
  #   end

  #   day_of_month = Time.zone.today.strftime('%e').to_i
  #   chart_start_date = Time.zone.today - 12.month - day_of_month
    
  #   tweets.each do |tweet| 
  #     if tweet.created_at > chart_start_date
  #       count = tweet.favorites_count
  #       tweet_month = tweet.created_at.strftime('%b')
  #       old_total = months[tweet_month]
  #       new_total = count + old_total
  #       months[tweet_month] = new_total
  #     end
  #   end  
  #   months.values
  # end

  # def mentions_chart_past_year
  #   options = {count: 200, include_rts: true}
  #   mentions = client.mentions_timeline(options)

  #   months = {}
  #   12.times do |i|
  #     months[past_year[i]] = 0
  #   end

  #   day_of_month = Time.zone.today.strftime('%e').to_i
  #   chart_start_date = Time.zone.today - 12.month - day_of_month
    
  #   mentions.each do |mention| 
  #     if mention.created_at > chart_start_date
  #       mention_month = mention.created_at.strftime('%b')
  #       old_total = months[mention_month]
  #       new_total = old_total + 1
  #       months[mention_month] = new_total
  #     end
  #   end  

  #   months.values
  # end

  def test
    page = MetaInspector.new('https://finishlinecorp.com/ties2elastic/let-your-product-tags-have-a-ball')
    return page.images.best
  end
 
end
