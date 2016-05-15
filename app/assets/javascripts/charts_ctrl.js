/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("chartsCtrl", function($scope, $http) {

    $scope.message = "hello";
    
    window.$scope = $scope;
  
  });
})();