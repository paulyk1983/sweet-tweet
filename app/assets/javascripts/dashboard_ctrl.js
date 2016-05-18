/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("dashboardCtrl", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/tweets.json').then(function(response) {
        $scope.tweets = response.data;
      });

      setTimeout(function() {
        var chart = document.getElementsByClassName("highcharts-container");
        chart[0].style["width"] = '835px';
      }, 1000);
    };

      

    window.$scope = $scope;
  });
})();