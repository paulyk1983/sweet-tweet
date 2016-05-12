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
      var wordCountSpan = document.getElementById("word-count");
      if ($scope.wordCount < 0) {
        wordCountSpan.style["color"] = 'red';
      } else {
        wordCountSpan.style["color"] = 'green';
      }
    };

    $scope.changeCount = function() {
      if (document.getElementById('image-input').value === 'true') {
        $scope.wordCount = 116 - $scope.message.length;
      } else {
        $scope.wordCount = 140 - $scope.message.length;
      }
      if ($scope.wordCount < 0) {
        document.getElementById("word-count").style["color"] = 'red';
      } else {
        document.getElementById("word-count").style["color"] = 'green';
      }
    };

    $scope.addImage = function() {
      document.getElementById('image-input').value = 'true';
      $scope.wordCount = $scope.wordCount - 24;

      var addImageButton = document.getElementById('add-image');
      addImageButton.className += " hidden";

      var removeImageButton = document.getElementById('remove-image');
      removeImageButton.className = removeImageButton.className.replace( ' hidden', '' );

      var image = document.getElementById('image');
      if (image.className === "animated fadeIn") {
        image.className = image.className.replace( 'animated fadeIn', 'animated zoomOutLeft' );
      } else {
        image.className += "animated zoomOutLeft";
      }
      setTimeout(function() {
        var imageThumb = document.getElementById('image-thumb');
        if (imageThumb.className === 'animated rollOut') {
          imageThumb.className = imageThumb.className.replace( 'animated rollOut', '' );
        } else {
          imageThumb.className = imageThumb.className.replace( 'hidden', '' );
        }
      }, 850);
      
    };

    $scope.removeImage = function() {
      document.getElementById('image-input').value = 'false';
      $scope.wordCount = $scope.wordCount + 24;
      var removeImageButton = document.getElementById('remove-image');
      removeImageButton.className += " hidden";

      var addImageButton = document.getElementById('add-image');
      addImageButton.className = removeImageButton.className.replace( ' hidden', '' );

      var imageThumb = document.getElementById('image-thumb');
      imageThumb.className += "animated rollOut";

      setTimeout(function() {
        var image = document.getElementById('image');
        image.className = image.className.replace( 'animated zoomOutLeft', 'animated fadeIn' );
      }, 700);
      
    };

    
    window.$scope = $scope;
  
  });
})();