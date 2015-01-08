angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "odigoSpots", "Trip", "MapManager",
    ($scope,   $window,   odigoSpots,   Trip,   MapManager) ->
      'use strict'

      trip = new Trip()
      newDay = trip.addDay()

      $scope.spots = odigoSpots[0].response
      $scope.tripSpots = trip.currentDay().spots()

      $scope.addToTrip = (spot) ->
        trip.currentDay().addSpot(spot)

      $scope.removeFromTrip = (spot) ->
        trip.currentDay().removeSpot(spot)

      do ->
        MapManager.init($scope.spots)
  ]
