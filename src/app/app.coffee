angular.module('tripManager', [
  'ngRoute'
  'uiGmapgoogle-maps'
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
.config (uiGmapGoogleMapApiProvider) ->
  uiGmapGoogleMapApiProvider.configure(
    key: 'AIzaSyDUsd_q4Ze8uN3t3lwj_kqPeYvZaSiSHHQ'
    v: '3.17'
    china: true
    libraries: 'weather,geometry,visualization'
  )
