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

        prevDay: ->
          if _days[_currentDayIndex - 1]?
            _currentDayIndex -= 1
          
        nextDay: ->
          if _days[_currentDayIndex + 1]?
            _currentDayIndex += 1
          
        addDay: (indexWhereAddTheDay = null) ->
          newDay = new TripDay()
          if indexWhereAddTheDay != null
            _days.splice indexWhereAddTheDay + 1, 0, newDay
          else
            _days.push newDay
          setCurrentDay newDay
          # @updateSpotsOrderIndex()
          # @saveToLocal()
          # @generateName()

        removeDay: (toBeDeletedDayIndex) ->
          console.log "removeDay " + toBeDeletedDayIndex
          _days = _.reject _days, (day, i) -> i == toBeDeletedDayIndex

          # if last day go to previous day
          @prevDay() if toBeDeletedDayIndex == _currentDayIndex && toBeDeletedDayIndex > 0

          # if no day, then add one.
          @addDay() if _days.length < 1

          # @generateName()

        # private methods

        setCurrentDay = (day) ->
          _currentDayIndex = i for d, i in _days when d is day
         
  ]
