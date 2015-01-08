angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "odigoSpots",
    ($scope,   $window,   odigoSpots) ->
      'use strict'

      $scope.spots = odigoSpots[0].response
      $scope.tripSpots = []

      $scope.addToTrip = (spot) ->
        $scope.tripSpots.push spot

      $scope.removeFromTrip = (spotId) ->
        $scope.tripSpots.splice i,1 for spot, i in $scope.tripSpots when spot.id == spotId

  ]
