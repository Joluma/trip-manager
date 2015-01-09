angular
  .module 'tripManager.trip'
  .factory "TripDay", [
    'DaySpot', 'DirectionsService',
    (DaySpot,   DirectionsService) ->
      class TripDay
        @_spots               : null
        @_currentDaySpotsHash : null
        @_tripPathPoints      : null

        constructor: () ->
          @_spots = []

        spots: ->
          @_spots

        containsSpot: (@spot) -> @_currentDaySpotsHash?[@spot.id]?

        addSpot: (@spot) ->
          @spot.orderIndex = @_spots.length
          @_spots.push new DaySpot(@spot)
          @updateSpotsCache()

        removeSpot: (@spot) ->
          @_spots.splice i,1 for spot, i in @_spots when spot?.id == @spot.id
          @updateSpotsCache()

        allSpotsBounds: ->
          bounds = new google.maps.LatLngBounds()
          bounds.extend(DirectionsService.coords2latlng spot.coords) for spot in @_spots
          bounds

        updateSpotsOrderIndex: -> spot.orderIndex = parseInt(index) for spot, index in @_spots

        numberOfTotalSpots: -> @_spots.length

        updateSpotsCache: ->
          @_currentDaySpotsHash = {}
          @_currentDaySpotsHash[item.id] = item for item in @_spots
          console.log @

        allSpotsHash: -> @_currentDaySpotsHash

        updatePath: ->
          return if @_spots.length < 2
          @_tripPathPoints = []
          @_tripPathPoints.push spot.coords for spot in @_spots

          @currentDay().tripPathPoints = RomeToRioService.setRoute(@_tripPathPoints).path

        trimedData: -> @

  ]
