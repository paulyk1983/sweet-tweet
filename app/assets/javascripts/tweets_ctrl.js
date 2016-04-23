/* global angular */

(function() {
  "use strict";

  angular.module("app").controller("employeesCtrl", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/employees.json').then(function(response) {
        $scope.employees = response.data;
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

    $scope.toggleSsn = function(employee) {

    };

    $scope.addEmployee = function(inputFirstName, inputLastName, inputSsn) {
      var newEmployee =  {
        first_name: inputFirstName,
        last_name: inputLastName,
        ssn: inputSsn
      };
      $http.post('/api/v1/employees.json', newEmployee).then(function(response) {
        console.log(response);
        $scope.employees.push(newEmployee);
      }, function(error) {
        $scope.errors = error.data.errors;
      });
    };

    $scope.removeEmployee = function(employee, index) {
      $http.delete('/api/v1/employees.json', employee).then(function(response) {
        console.log(response);
        $scope.employees.splice(index, 1);
      });
    };

    window.$scope = $scope;
  });
})();