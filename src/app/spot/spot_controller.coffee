angular
  .module 'tripManager.spot'
  .controller 'SpotCtrl', [
    "$scope", "$routeParams", "SpotsManager", "$timeout"
    ($scope,   $routeParams,   SpotsManager,   $timeout) ->
      'use strict'

      _spots = []

      $scope.goToPrevSpot = ->
        _previousSpot = _spots[$scope.spot.orderIndex - 1]
        window.location.href = "#/spot/#{_previousSpot.id}" if _previousSpot?

      $scope.goToNextSpot = ->
        _nextSpot = _spots[$scope.spot.orderIndex + 1]
        window.location.href = "#/spot/#{_nextSpot.id}" if _nextSpot?

      do ->
        _spots = SpotsManager.spots()
        $timeout ->
          $scope.spot = SpotsManager.spotsHash()[$routeParams.spotId]
        , 2000
  ]
