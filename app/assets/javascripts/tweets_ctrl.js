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

    $scope.submitUrl = function() {
      $http.post(
        "https://www.googleapis.com/urlshortener/v1/url?key=" + shortener_key,
        {"longUrl": "https://finishlinecorp.com"}
      ).then(function(response) {
        console.log(response);
      }, function(error) {
        $scope.errors = error.data.errors;
      });
    };
    

    
    window.$scope = $scope;
  });
})();