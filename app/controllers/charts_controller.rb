class ChartsController < ApplicationController
  def show

    day_of_month = Time.zone.today.strftime('%e').to_i
    @test = chart_start_date = Time.zone.today - (12 - 1).month - day_of_month
   
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

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end

    @chart2 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Tweet Performance - Last 12 Months")
      f.xAxis(categories: current_user.past_year)      
      f.series(name: "Retweets", yAxis: 0, data: current_user.chart(12, 'retweets', current_user.tweets))
      f.series(name: "Favorites", yAxis: 1, data: current_user.chart(12, 'favorites', current_user.tweets))
      f.series(name: "Mentions", yAxis: 1, data: current_user.chart_mentions(12, current_user.mentions))

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
