/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("dashboardCtrl", function($scope) {

    $scope.setup = function() {
      setTimeout(function() {
        var chart = document.getElementsByClassName("highcharts-container");
        chart[0].style["width"] = '835px';
      }, 1000);
    };

      

    window.$scope = $scope;
  });
})();