class TweetsController < ApplicationController
  def index
   
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Monthly Tweet Performance")
      f.xAxis(categories: current_user.past_six_months)
      f.series(name: "Retweets", yAxis: 0, data: current_user.retweet_chart)
      f.series(name: "Likes", yAxis: 1, data: [4, 14, 30, 44, 20])

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

  def new
    @url = Page.first.long_url
  end

  def create
    current_user.tweet(twitter_params[:message])
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
