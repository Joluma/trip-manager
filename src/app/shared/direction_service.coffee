angular
  .module 'tripManager'
  .factory "DirectionsService", ["$interval", "$q", ($interval, $q) ->
    _isRequesting = false
    _directionsService = new google.maps.DirectionsService()
    _taskQueue = []

    _startRunQueue = ->
      _interval = $interval ->
        if _taskQueue.length > 0
          _getRoute()
        else
          $interval.cancel _interval
      , 400

    _getRoute = () ->
      data = _taskQueue.shift()
      _directionsService.route data.routeOptions, (response, status) ->
        data.deferred.resolve {response: response, status: status}
      data.deferred.promise

    {
      getRoute: (routeOptions) ->
        _deferred = $q.defer()
        _taskQueue.push {
          deferred: _deferred
          routeOptions: routeOptions
        }
        _startRunQueue()
        _deferred.promise

      # thin layer for promise api
      routePromise: (request) ->
        d = $q.defer()
        _directionsService.route request, (response, status) ->
          if status == google.maps.DirectionsStatus.OK
            d.resolve(response, status)
          else
            d.reject(response, status)
        d.promise

      coords2latlng: (coords) ->
        new google.maps.LatLng(coords.latitude, coords.longitude)

      computeDistanceBetween: (latlng1, latlng2) ->
        google.maps.geometry.spherical.computeDistanceBetween(latlng1, latlng2)
    }
  ]
