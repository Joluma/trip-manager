angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "odigoSpots", "Trip", "MapManager",
    ($scope,   $window,   odigoSpots,   Trip,   MapManager) ->
      'use strict'

      trip = new Trip()
      trip.addDay()

      $scope.spots = odigoSpots[0].response
      $scope.tripSpots = trip.currentDay().spots()
      
      $scope.currentDay = -> trip.currentDayIndex()

      $scope.addToTrip = (spot) ->
        trip.currentDay().addSpot(spot)

      $scope.removeFromTrip = (spot) ->
        trip.currentDay().removeSpot(spot)

      $scope.prevDay = ->
        trip.prevDay()

      $scope.nextDay = ->
        trip.nextDay()

      $scope.addDay = ->
        trip.addDay()

      do ->
        MapManager.init($scope.spots)
  ]
