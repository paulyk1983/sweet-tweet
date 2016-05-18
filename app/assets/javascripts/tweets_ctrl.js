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
      $scope.sortDir = true;
      if (inputAttribute === 'created_on') {
        $scope.sortDir = false;
      }
      $scope.orderAttribute = inputAttribute;
    };

    $scope.addCount = function() {
      $scope.wordCount = 140 - $scope.message.length;
      var wordCountSpan = document.getElementById("word-count");
      if ($scope.wordCount < 0) {
        wordCountSpan.style["color"] = 'red';
        document.getElementById("submit-tweet-btn").style["display"] = "none";
        document.getElementById("submit-alert-btn").style["display"] = "inline";
      } else {
        wordCountSpan.style["color"] = 'green';
        document.getElementById("submit-tweet-btn").style["display"] = "inline";
        document.getElementById("submit-alert-btn").style["display"] = "none";
      }
    };

    $scope.changeCount = function() {
      if (document.getElementById('image-input').value === 'true') {
        $scope.wordCount = 116 - $scope.message.length;
      } else {
        $scope.wordCount = 140 - $scope.message.length;
      }
      var wordCountSpan = parseInt(document.getElementById("word-count").innerHTML);
      if (wordCountSpan < 0) {
        document.getElementById("word-count").style["color"] = 'red';
        document.getElementById("submit-tweet-btn").style["display"] = "none";
        document.getElementById("submit-alert-btn").style["display"] = "inline";
      } else {
        document.getElementById("word-count").style["color"] = 'green';
        document.getElementById("submit-tweet-btn").style["display"] = "inline";
        document.getElementById("submit-alert-btn").style["display"] = "none";
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

      setTimeout(function() {
        var wordCountSpan = parseInt(document.getElementById("word-count").innerHTML);
        if (wordCountSpan < 0) {
          document.getElementById("word-count").style["color"] = 'red';
          document.getElementById("submit-tweet-btn").style["display"] = "none";
          document.getElementById("submit-alert-btn").style["display"] = "inline";
        } else {
          document.getElementById("word-count").style["color"] = 'green';
          document.getElementById("submit-tweet-btn").style["display"] = "inline";
          document.getElementById("submit-alert-btn").style["display"] = "none";
        }
      }, 1000);

      var formUrl = document.getElementById("tweet-form").action;
      formUrl = formUrl.replace("true", "false");
    };

    $scope.removeImage = function() {
      document.getElementById('image-input').value = 'false';
      $scope.wordCount = $scope.wordCount + 24;
      var removeImageButton = document.getElementById('remove-image');
      removeImageButton.className += " hidden";

      var addImageButton = document.getElementById('add-image');
      addImageButton.className = addImageButton.className.replace( ' hidden', '' );

      var imageThumb = document.getElementById('image-thumb');
      imageThumb.className += "animated rollOut";

      setTimeout(function() {
        var image = document.getElementById('image');
        image.className = image.className.replace( 'animated zoomOutLeft', 'animated fadeIn' );
      }, 700);

      setTimeout(function() {
        var wordCountSpan = parseInt(document.getElementById("word-count").innerHTML);
        if (wordCountSpan < 0) {
          document.getElementById("word-count").style["color"] = 'red';
          document.getElementById("submit-tweet-btn").style["display"] = "none";
          document.getElementById("submit-alert-btn").style["display"] = "inline";
        } else {
          document.getElementById("word-count").style["color"] = 'green';
          document.getElementById("submit-tweet-btn").style["display"] = "inline";
          document.getElementById("submit-alert-btn").style["display"] = "none";
        }
      }, 1000);
      
    };

    $scope.submitAlert = function() {
      alert('You have to many characters in your tweet. Delete characters or remove image');
      return false;
    };

    
    window.$scope = $scope;
  
  });
})();