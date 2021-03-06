class DashboardController < ApplicationController
  def show    
    unless current_user.twitter_handle
      user_twitter_handle = current_user.client.user.screen_name
      current_user.update(twitter_handle: user_twitter_handle)
    end

    unless current_user.tweets.first
      options = {count: 200, include_rts: true}
      tweets = current_user.client.user_timeline(current_user.twitter_handle, options)
      tweets.each do |tweet|
        if !tweet.media[0]
          image = ''
        else
          image = tweet.media[0].media_url
        end
        Tweet.create(
          user_id: current_user.id,
          retweets_count: tweet.retweet_count,
          favorites_count: tweet.favorites_count,
          image: image,
          message: tweet.text,
          tweet_time: tweet.created_at,
          twitter_id: tweet.id.to_s
        )
      end
    end

    if current_user.tweets.count == 199
      options = {count: 200, include_rts: true, max_id: Tweet.last.twitter_id.to_i}
      tweets = current_user.client.user_timeline(current_user.twitter_handle, options)
      tweets.each do |tweet|
        if !tweet.media[0]
          image = ''
        else
          image = tweet.media[0].media_url
        end
        Tweet.create(
          user_id: current_user.id,
          retweets_count: tweet.retweet_count,
          favorites_count: tweet.favorites_count,
          image: image,
          message: tweet.text,
          tweet_time: tweet.created_at,
          twitter_id: tweet.id.to_s
        )
      end
    end

    unless current_user.mentions.first
      mentions = current_user.client.mentions_timeline({count: 200})
      mentions.each do |mention|
        Mention.create(
          user_id: current_user.id,
          mention_time: mention.created_at
        )
      end
    end

    unless current_user.profile_pic
      profile_pic = current_user.client.user.profile_image_url
      current_user.update(profile_pic: profile_pic)
    end

    unless current_user.profile_page
      profile_page = current_user.client.user.url
      current_user.update(profile_page: profile_page)
    end

    unless current_user.followers.first
      followers = current_user.client.users('BrennerMichael', 'eC0mmerceDev', 'Tanisha_Paskey', 'PowerShieldPL', 'RobbedOfSleep')
      followers.each do |follower|
        Follower.create(
          user_id: current_user.id,
          twitter_id: follower.id.to_s,
          profile_image: follower.profile_image_url,
          profile_page: follower.url,
          name: name
        )
      end
    end

    @followers = current_user.followers
    @followers.each do |follower|
      if follower.name == 'Tanisha _Paskey'
        @friendship_status = 'You are not following' 
      else
        @friendship_status = 'You are following'
      end 
    end
    @pending_pages = Page.where("status = ? AND user_id = ?", 'pending', current_user.id) 

    options = {count: 25, include_rts: true}
    keys = current_user.client
    recent_tweets = keys.user_timeline(current_user.twitter_handle, options)
    recent_mentions = keys.mentions_timeline(options)

    @retweets_today = current_user.past_day('retweets', recent_tweets)
    @favorites_today = current_user.past_day('favorites', recent_tweets)
    @mentions_today = current_user.past_day('mentions', recent_mentions)

    @chart1 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Tweet Performance - Last 6 Months")
      f.xAxis(categories: current_user.past_six_months)
      f.series(name: "Retweets", yAxis: 0, data: current_user.chart(6, 'retweets', current_user.tweets))
      f.series(name: "Favorites", yAxis: 1, data: current_user.chart(6, 'favorites', current_user.tweets))
      f.series(name: "Mentions", yAxis: 1, data: current_user.chart_mentions(6, current_user.mentions))

      f.yAxis [
        {title: {text: "", margin: 70} },
        {title: {text: ""}, opposite: true}
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -70, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end

    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        backgroundColor: {
          linearGradient: [0, 0, 500, 500],
          stops: [
            [0, "rgb(255, 255, 255)"],
            [1, "rgb(240, 240, 255)"]
          ]
        },
        borderWidth: 2,
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: true,
        plotBorderWidth: 1
      )
      f.lang(thousandsSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
    end
  end
end
