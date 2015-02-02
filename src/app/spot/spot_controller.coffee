angular
  .module 'tripManager.spot'
  .controller 'SpotCtrl', [
    "$scope", "$routeParams", "SpotsManager", "$hotkey", "$timeout",
    ($scope,   $routeParams,   SpotsManager,   $hotkey,   $timeout) ->
      'use strict'

      $scope.pageClass = "page-spot"
      
      if $routeParams.dir is "p"
        $scope.directionClass = "go-previous"
      else if $routeParams.dir is "n"
        $scope.directionClass = "go-next"

      _spots = []

      $scope.goToPrevSpot = ->
        $scope.directionClass = "go-previous"
        $timeout ->
          _previousSpot = _spots[$scope.spot.orderIndex - 1]
          window.location.href = "#/spot/#{_previousSpot.id}/p" if _previousSpot?
        , 0

      $scope.goToNextSpot = ->
        $scope.directionClass = "go-next"
        $timeout ->
          _nextSpot = _spots[$scope.spot.orderIndex + 1]
          window.location.href = "#/spot/#{_nextSpot.id}/n" if _nextSpot?
        , 0

      do ->
        _spots = SpotsManager.spots()
        $scope.spot = SpotsManager.spotsHash()[$routeParams.spotId]

        $hotkey.bind 'left', ->
          $scope.directionClass = "go-previous"
          $scope.goToPrevSpot()
        $hotkey.bind 'right', ->
          $scope.goToNextSpot()

      $scope.$on "$destroy", ->
        $scope.pageClass = ""
        $scope.directionClass = ""

        $hotkey.unbind 'left', ->
          $scope.goToPrevSpot()
        $hotkey.unbind 'right', ->
          $scope.goToNextSpot()
  ]
