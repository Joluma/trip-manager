angular
  .module 'tripManager.trip'
  .factory "Trip", [
    'TripDay',
    (TripDay) ->
      class Trip
        _days = null
        _currentDayIndex = null

        constructor: () ->
          _days = []
          _currentDayIndex = -1

        days: -> _days
        
        currentDayIndex: -> _currentDayIndex

        currentDay: -> _days[_currentDayIndex]

        prevDay: -> _currentDayIndex -= 1 if _days[_currentDayIndex - 1]?
          
        nextDay: -> _currentDayIndex += 1 if _days[_currentDayIndex + 1]?
          
        jumpToDay: (dayIndex) -> _currentDayIndex = parseInt dayIndex if _days[dayIndex]?

        addDay: (indexWhereAddTheDay = null) ->
          newDay = new TripDay()
          if indexWhereAddTheDay != null
            _days.splice indexWhereAddTheDay + 1, 0, newDay
          else
            _days.push newDay
          @setCurrentDay newDay
          @updateDaysOrderIndex()
          @generateTitle()
          @saveDraft()

        removeDay: (toBeDeletedDayIndex) ->
          console.log "removeDay " + toBeDeletedDayIndex
          _days = _.reject _days, (day, i) -> i == toBeDeletedDayIndex

          # if last day go to previous day
          @prevDay() if toBeDeletedDayIndex == _currentDayIndex && toBeDeletedDayIndex > 0

          # if no day, then add one.
          @addDay() if _days.length < 1

          @generateTitle()

        numberOfTotalSpots: ->
          _numberOfTotalSpots = 0
          _numberOfTotalSpots += day.spots().length for day in _days
          _numberOfTotalSpots

        # private methods

        setCurrentDay: (day) -> _currentDayIndex = i for d, i in _days when d is day
        
        updateDaysOrderIndex: ->  day.orderIndex = parseInt(index) for day, index in _days

        # change this method with the server side generation when we merge to odigo
        generateTitle: -> @title = "#{_days.length} days trip"

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
          trimedTrip.days = _.map _days, (day) ->
            trimedDay = day.trimedData()
            trimedDay.spots = _.map day.spots(), (spot) ->
              spot.trimedData()
            trimedDay
          trimedTrip.toBeDeleted = @toBeDeleted
          trimedTrip

  ]
