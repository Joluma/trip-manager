angular.module('tripManager', [
  'ngRoute'
  'ngAnimate'
  'uiGmapgoogle-maps'
  'tripManager.trip'
  'tripManager.spot'
  'ngMap'
  'drahak.hotkeys'
])
.config ($routeProvider) ->
  'use strict'
  $routeProvider
    .when '/trip',
      controller: 'TripCtrl'
      templateUrl: '/trip/trip.html'
    .when '/spot/:spotId',
      controller: 'SpotCtrl'
      templateUrl: '/spot/spot.html'
    .when '/timeline',
      controller: 'TimelineCtrl'
      templateUrl: '/spot/timeline.html'
    .otherwise
      redirectTo: '/trip'
.config (uiGmapGoogleMapApiProvider) ->
  uiGmapGoogleMapApiProvider.configure(
    key: 'AIzaSyDUsd_q4Ze8uN3t3lwj_kqPeYvZaSiSHHQ'
    v: '3.17'
    china: true
    libraries: 'weather,geometry,visualization'
  )
