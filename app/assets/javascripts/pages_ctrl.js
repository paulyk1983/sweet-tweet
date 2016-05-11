/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("pagesCtrl", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/pages.json').then(function(response) {
        $scope.pages = response.data;
      });
    };
    
    window.$scope = $scope;
  });
})();