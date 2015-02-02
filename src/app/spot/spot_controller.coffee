angular
  .module 'tripManager.spot'
  .controller 'SpotCtrl', [
    "$scope", "$routeParams", "SpotsManager", "$hotkey",
    ($scope,   $routeParams,   SpotsManager,   $hotkey) ->
      'use strict'

      $scope.pageClass = "page-spot"

      _spots = []

      $scope.goToPrevSpot = ->
        _previousSpot = _spots[$scope.spot.orderIndex - 1]
        $scope.pageClass = "page-spot-prev"
        window.location.href = "#/spot/#{_previousSpot.id}" if _previousSpot?

      $scope.goToNextSpot = ->
        _nextSpot = _spots[$scope.spot.orderIndex + 1]
        $scope.pageClass = "page-spot-next"
        window.location.href = "#/spot/#{_nextSpot.id}" if _nextSpot?

      do ->
        _spots = SpotsManager.spots()
        $scope.spot = SpotsManager.spotsHash()[$routeParams.spotId]

        $hotkey.bind 'left', ->
          $scope.goToPrevSpot()
        $hotkey.bind 'right', ->
          $scope.goToNextSpot()

      $scope.$on "$destroy", ->        
        $hotkey.unbind 'left', ->
          $scope.goToPrevSpot()
        $hotkey.unbind 'right', ->
          $scope.goToNextSpot()
  ]
