angular
  .module 'tripManager.trip'
  .factory "Trip", [
    'TripDay', '$rootScope', 'Pubsub',
    (TripDay,   $rootScope,   Pubsub) ->
      class Trip
        constructor: () ->
          @monitorChanges()
          @days = []
          @currentDayIndex = -1

        currentDay: -> @days[@currentDayIndex]

        prevDay: -> @currentDayIndex -= 1 if @days[@currentDayIndex - 1]?
          
        nextDay: -> @currentDayIndex += 1 if @days[@currentDayIndex + 1]?
          
        jumpToDay: (dayIndex) -> @currentDayIndex = parseInt dayIndex if @days[dayIndex]?

        addDay: (indexWhereAddTheDay = null) ->
          newDay = new TripDay()
          if indexWhereAddTheDay != null
            @days.splice indexWhereAddTheDay + 1, 0, newDay
          else
            @days.push newDay
          @setCurrentDay newDay
          @updateDaysOrderIndex()
          @generateTitle()
          @saveDraft()

        removeDay: (toBeDeletedDayIndex) ->
          console.log "removeDay " + toBeDeletedDayIndex
          @days = _.reject @days, (day, i) -> i == toBeDeletedDayIndex

          # if last day go to previous day
          @prevDay() if toBeDeletedDayIndex == @currentDayIndex && toBeDeletedDayIndex > 0

          # if no day, then add one.
          @addDay() if @days.length < 1

          @generateTitle()

        numberOfTotalSpots: ->
          _numberOfTotalSpots = 0
          _numberOfTotalSpots += day.spots().length for day in @days
          _numberOfTotalSpots

        # private methods

        setCurrentDay: (day) -> @currentDayIndex = i for d, i in @days when d is day
        
        updateDaysOrderIndex: ->  day.orderIndex = parseInt(index) for day, index in @days

        generateTitle: -> @title = "#{@days.length} days trip"

        saveDraft: ->
          if @tripId?
            @autoSave()
          else
            localStorage.setItem 'currentTrip', JSON.stringify(@trimedData())

        loadFromLocal: ->
          @setCurrentTrip localStorage.getItem('currentTrip')
          @setLocalTrip localStorage.getItem('currentTrip')
          @updateTripPathPoints()

        trimedData: ->
          trimedTrip = {}
          trimedTrip.title = @title
          trimedTrip.destination = @destination
          trimedTrip.start_day = @start_day
          trimedTrip.desc = @desc
          trimedTrip.days = _.map @days, (day) ->
            trimedDay = day.trimedData()
            trimedDay.spots = _.map day.spots(), (spot) ->
              spot.trimedData()
            trimedDay
          trimedTrip.toBeDeleted = @toBeDeleted
          trimedTrip

        tripChangedCallbacks: -> Pubsub.pub "updateMap"

        monitorChanges: ->
          $rootScope.$watchCollection =>
            @days
          , => @tripChangedCallbacks()

          $rootScope.$watchCollection =>
            @days[@currentDayIndex]?._spots
          , => @tripChangedCallbacks()

  ]
