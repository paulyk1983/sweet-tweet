/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("tweetsCtrl", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/employees.json').then(function(response) {
        $scope.tweets = response.data;
      });
    };


    window.$scope = $scope;
  });
})();