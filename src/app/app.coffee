angular.module('tripManager', [
  'ngRoute'
  'tripManager.trip'
])
.config ($routeProvider) ->
  'use strict'
  $routeProvider
    .when '/trip',
      controller: 'TripCtrl'
      templateUrl: '/trip/trip.html'
    .otherwise
      redirectTo: '/trip'
