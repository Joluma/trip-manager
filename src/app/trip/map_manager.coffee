angular
  .module 'tripManager.trip'
  .service 'MapManager', [
    () ->
      'use strict'

      _map = null
      _currentDaySpotsPath = null
      _markers = []
      _markersHash = {}

      _addMarkers = (spots) ->
        for spot in spots
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

        markerCluster = new MarkerClusterer(_map, _markers)

      _updateMarkers = (spots) ->
        for spot in spots
          if _markersHash[spot.id]?
            _markers[_markersHash[spot.id].oderIndex].setIcon("assets/img/iconFood.png")

      _updatePath = (spots) ->
        _currentDaySpotsPath?.setMap(null)
        _currentDaySpotsCoords = []

        for spot in spots
          _currentDaySpotsCoords.push new google.maps.LatLng(spot.coords.latitude, spot.coords.longitude)

        _currentDaySpotsPath = new google.maps.Polyline({
          path: _currentDaySpotsCoords,
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 4
        })

        _currentDaySpotsPath.setMap(_map)

      {
        init: (spots) ->
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
          # for spot in spots
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

          _addMarkers spots

        updateMap: (spots) ->
          _updateMarkers spots
          _updatePath spots
      }
  ]
