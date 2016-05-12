/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("pagesCtrl", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/pages.json').then(function(response) {
        var divPages = document.getElementById('pages');
        console.log(response);
        divPages.innerHTML(response);
      });
    };

    $scope.submitUrl = function() {
    };

    
    window.$scope = $scope;
  });
})();