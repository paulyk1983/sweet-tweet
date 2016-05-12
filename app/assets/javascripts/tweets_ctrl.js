/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("tweetsCtrl", function($scope, $http) {

    $scope.message = "";
    $scope.setup = function() {
      $http.get('/api/v1/tweets.json').then(function(response) {
        $scope.tweets = response.data;
      });
    };

    $scope.changeOrderAttribute = function(inputAttribute) {
      $scope.orderAttribute = inputAttribute;
    };

    $scope.addCount = function() {
      $scope.wordCount = 140 - $scope.message.length;
      if ($scope.wordCount < 0) {
        document.getElementById("word-count").style["color"] = 'red';
      } else {
        document.getElementById("word-count").style["color"] = 'green';
      }
    };
      
    
    window.$scope = $scope;
  });
})();