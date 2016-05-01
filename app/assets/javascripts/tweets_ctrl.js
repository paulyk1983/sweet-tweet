/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("tweetsCtrl", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/tweets.json?count=50').then(function(response) {
        $scope.tweets = response.data;
      });
    };

    $scope.changeOrderAttribute = function(inputAttribute) {
      if (inputAttribute !== $scope.orderAttribute) {
        $scope.orderDescending = false;
      } else {
        $scope.orderDescending = !$scope.orderDescending;
      }
      $scope.orderAttribute = inputAttribute;
    };


    window.$scope = $scope;
  });
})();