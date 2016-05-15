/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("chartsCtrl", function($scope, $http) {  
    
    $scope.hideChart = function() {
      var chartTwo = document.getElementById('chart-2');
      setTimeout(function() {
        chartTwo.className += 'hidden';
      }, 800);
    };

    $scope.showChartOne = function() {
      var chartOne = document.getElementById('chart-1');
      var chartTwo = document.getElementById('chart-2');
      if (chartTwo.className !== 'hidden') {
        chartTwo.className += 'hidden';
      }
      if (chartOne.className === 'hidden') {
        chartOne.className = chartOne.className.replace("hidden", "");
      }
    };

    $scope.showChartTwo = function() {
      var chartOne = document.getElementById('chart-1');
      var chartTwo = document.getElementById('chart-2');
      var chartOneButton = document.getElementById('button');
      if (chartTwo.className === 'hidden') {
        chartTwo.className = chartTwo.className.replace("hidden", "");
      }
      if (chartOne.className !== 'hidden') {
        chartOne.className += 'hidden';
      }
      if (chartOneButton.className.indexOf('active') !== -1) {
        chartOneButton.className = chartOneButton.className.replace(" active", "");
      }
    };

    $scope.toggleSeries = function(event) {
      var series = document.getElementsByClassName('highcharts-series highcharts-tracker');
      var retweets1 = series[0];
      var favorites1 = series[1];
      var mentions1 = series[2];
      var retweets2 = series[3];
      var favorites2 = series[4];
      var mentions2 = series[5];
      console.log(series);
      if (event === 0) {
        if (retweets1.style["display"] === 'none') {
          retweets1.style["display"] = '';
          retweets2.style["display"] = '';
        } else {
          retweets1.style["display"] = 'none';
          retweets2.style["display"] = 'none';
        }
      } else if (event === 1 ) {
        if (favorites1.style["display"] === 'none') {
          favorites1.style["display"] = '';
          favorites2.style["display"] = '';
        } else {
          favorites1.style["display"] = 'none';
          favorites2.style["display"] = 'none';
        }
      } else {
        if (mentions1.style["display"] === 'none') {
          mentions1.style["display"] = '';
          mentions2.style["display"] = '';
        } else {
          mentions1.style["display"] = 'none';
          mentions2.style["display"] = 'none';
        }
      }
      
      
      
    };
    
    window.$scope = $scope;
  
  });
})();