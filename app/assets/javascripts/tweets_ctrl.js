/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("tweetsCtrl", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/tweets.json').then(function(response) {
        $scope.tweets = response.data;
      });
    };

    $scope.changeOrderAttribute = function(inputAttribute) {
      $scope.orderAttribute = inputAttribute;
    };
    
    window.$scope = $scope;
  });
})();