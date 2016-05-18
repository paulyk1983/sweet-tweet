class DashboardController < ApplicationController
  def show
    unless current_user.twitter_handle
      user_twitter_handle = current_user.client.user.screen_name
      current_user.update(twitter_handle: user_twitter_handle)
    end

    @pending_pages = Page.where("status = ? AND user_id = ?", 'pending', current_user.id) 

    options = {count: 200, include_rts: true}
    keys = current_user.client
    # follower_ids = keys.followers(current_user.twitter_handle)
    # follower_id_list = []
    # follower_ids.each_with_index do |follower_id, i|
    #   if i < 5
    #     follower_id_list << follower_id.id
    #   end
    # end
    # @followers = keys.users(follower_id_list)
    tweets = keys.user_timeline(current_user.twitter_handle, options)
    mentions = keys.mentions_timeline(options)

    @retweets_today = current_user.past_day('retweets', tweets)
    @favorites_today = current_user.past_day('favorites', tweets)
    @mentions_today = current_user.past_day('mentions', mentions)

    @chart1 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Tweet Performance - Last 6 Months")
      f.xAxis(categories: current_user.past_six_months)
      f.series(name: "Retweets", yAxis: 0, data: current_user.chart(6, 'retweets', tweets))
      f.series(name: "Favorites", yAxis: 1, data: current_user.chart(6, 'favorites', tweets))
      f.series(name: "Mentions", yAxis: 1, data: current_user.chart(6, 'mentions', mentions))

      f.yAxis [
        {title: {text: "", margin: 70} },
        {title: {text: ""}, opposite: true}
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
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
