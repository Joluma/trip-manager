angular
  .module 'tripManager.trip'
  .service 'MapManager', [
    'TripManager', 'Pubsub', 'SpotsManager',
    (TripManager,   Pubsub,   SpotsManager) ->
      'use strict'

      _map                 = null
      _markerCluster       = null
      _currentDaySpotsPath = null
      _markers             = []
      _markersHash         = {}

      _allSpots            = []
      _tripSpots           = []
      _tripSpotsHash       = {}

      _addMarkers = () ->
        for spot in _allSpots
          return if _markersHash[spot.id]?
          _markersHash[spot.id] = spot
          _markersHash[spot.id].oderIndex = _markers.length
          marker = new google.maps.Marker({
            position: new google.maps.LatLng(spot.coords.latitude, spot.coords.longitude),
            map: _map,
            title: spot.name,
            icon: "assets/img/iconDefault.png"
          })
          _markers.push marker

        _markerCluster = new MarkerClusterer(_map, _markers)

      _updateMarkers = () ->
        for spot in _allSpots
          if _tripSpotsHash?[spot.id]?
            _markers[_markersHash[spot.id].oderIndex].setIcon("assets/img/iconFood.png")
          else
            _markers[_markersHash[spot.id].oderIndex].setIcon("assets/img/iconDefault.png")

      _updatePath = () ->
        _currentDaySpotsPath?.setMap(null)
        _currentDaySpotsCoords = []

        for spot in _tripSpots
          _currentDaySpotsCoords.push new google.maps.LatLng(spot.coords.latitude, spot.coords.longitude)

        _currentDaySpotsPath = new google.maps.Polyline({
          path: _currentDaySpotsCoords,
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 4
        })

        _currentDaySpotsPath.setMap(_map)

      Pubsub.sub "updateMap", ->
        _tripSpots = TripManager.trip.currentDay().spots()
        _tripSpotsHash = TripManager.trip.currentDay().allSpotsHash()
        _updateMarkers()
        _updatePath()

      Pubsub.sub "centerMapOnSpot", (event, spotCoords) ->
        _map.setCenter(new google.maps.LatLng(spotCoords.latitude, spotCoords.longitude))

      {
        init: () ->
          _allSpots = SpotsManager.spots()
          ############### map with angular google map
          # $(".angular-google-map-container").height($(window).height())
          # {
          #   center:
          #     latitude: 35.673343
          #     longitude: 139.710388
          #   zoom: 9
          # }

          ############### map with mapbox
          # map = L.map('map').setView([35.673343,139.710388], 9)

          # L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          #     attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
          # }).addTo(map)

          # markers = new L.MarkerClusterGroup()
          # for spot in _allSpots
          #   marker = L.marker(new L.LatLng(spot.coords.latitude, spot.coords.longitude), {
          #     title: spot.name
          #   })
          #   marker.bindPopup 'Welcome to <br> '+spot.name
          #   markers.addLayer marker
          # map.addLayer markers

          ############### map with google map
          mapOptions =
            center:
              lat: 35.673343
              lng: 139.710388
            zoom: 10

          _map = new google.maps.Map(document.getElementById('map'), mapOptions)

          _addMarkers()
      }
  ]
