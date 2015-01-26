angular
  .module 'tripManager.trip'
  .service 'MapManager', [
    () ->
      'use strict'

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

          map = new google.maps.Map(document.getElementById('map'), mapOptions)

          markers = []

          for spot in spots
            marker = new google.maps.Marker({
              position: new google.maps.LatLng(spot.coords.latitude, spot.coords.longitude),
              map: map,
              title: spot.name
            })
            markers.push marker

          markerCluster = new MarkerClusterer(map, markers)
      }
  ]
