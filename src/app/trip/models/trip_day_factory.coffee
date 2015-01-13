angular
  .module 'tripManager.trip'
  .factory "TripDay", [
    'DaySpot', 'DirectionsService',
    (DaySpot,   DirectionsService) ->
      class TripDay
        constructor: () ->
          @_orderIndex          = null
          @_spots               = []
          @_path                = []
          @_startBase           = null
          @_endBase             = null
          @_currentDaySpotsHash = null

        spots: -> @_spots

        containsSpot: (@spot) -> @_currentDaySpotsHash?[@spot.id]?

        addSpot: (@spot) ->
          @spot.orderIndex = @_spots.length
          @_spots.push new DaySpot(@spot)
          @updateSpotsOrderIndex()
          @updateSpotsCache()

        removeSpot: (@spot) ->
          @_spots.splice i,1 for spot, i in @_spots when spot?.id == @spot.id
          @updateSpotsCache()

        allSpotsBounds: ->
          bounds = new google.maps.LatLngBounds()
          bounds.extend(DirectionsService.coords2latlng spot.coords) for spot in @_spots
          bounds.extend(DirectionsService.coords2latlng @_startBase.coords) if @_startBase?
          bounds.extend(DirectionsService.coords2latlng @_endBase.coords) if @_endBase?
          bounds

        updateSpotsOrderIndex: -> spot.orderIndex = parseInt(index) for spot, index in @_spots

        # this one may be useless we can use 'day._spots.length'
        numberOfTotalSpots: -> @_spots.length

        updateSpotsCache: ->
          @_currentDaySpotsHash = {}
          @_currentDaySpotsHash[item.id] = item for item in @_spots

        # this one may be useless we can use 'day._currentDaySpotsHash'
        allSpotsHash: -> @_currentDaySpotsHash

        optimizeRoute: -> ""

        updatePath: ->
          return if @_spots.length < 2
          @_path = []
          @_path.push spot.coords for spot in @_spots

          @currentDay().tripPathPoints = RomeToRioService.setRoute(@_path).path

        trimedData: ->
          trimedDay = {}
          trimedDay.id = @id
          trimedDay.orderIndex = @orderIndex
          if @startBase?
            trimedDay.startBase = {}
            trimedDay.startBase.name = @startBase.name
            trimedDay.startBase.coords = @startBase.coords
          if @endBase?
            trimedDay.endBase = {}
            trimedDay.endBase.name = @endBase.name
            trimedDay.endBase.coords = @endBase.coords
          trimedDay
  ]
