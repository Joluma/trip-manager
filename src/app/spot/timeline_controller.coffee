angular
  .module 'tripManager.spot'
  .controller 'TimelineCtrl', [
    "$scope", "SpotsManager",
    ($scope,   SpotsManager) ->
      'use strict'

      $scope.pageClass = "page-timeline"
      $scope.spots = SpotsManager.spots()

  ]
