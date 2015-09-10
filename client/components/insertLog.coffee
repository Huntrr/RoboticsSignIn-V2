# jquery time picker stuff

Template.insertLog.rendered = () ->
  $('#date-picker').datetimepicker({ format: 'MM/DD/YYYY', defaultDate: Date.now() })
  $('#start-picker').datetimepicker({ format: 'LT', defaultDate: Date.now() })
  $('#end-picker').datetimepicker({ format: 'LT', defaultDate: Date.now() })

  $('#start-picker').on 'dp.change', (e) ->
    $('#end-picker').data("DateTimePicker").minDate(e.date)
  $('#end-picker').on 'dp.change', (e) ->
    $('#start-picker').data("DateTimePicker").maxDate(e.date)
    
Template.insertLog.events
  'submit .add-entry': (e) ->
    e.preventDefault()

    date = $('#date-picker').data("DateTimePicker").date().toDate()
    startTime = $('#start-picker').data("DateTimePicker").date().toDate()
    endTime = $('#end-picker').data("DateTimePicker").date().toDate()

    start = new Date(date.getFullYear(), date.getMonth(), date.getDate(), startTime.getHours(), startTime.getMinutes())
    end = new Date(date.getFullYear(), date.getMonth(), date.getDate(), endTime.getHours(), endTime.getMinutes())

    $('#date-picker').data("DateTimePicker").date(new Date())
    $('#start-picker').data("DateTimePicker").date(new Date())
    $('#end-picker').data("DateTimePicker").date(new Date())

    Meteor.call('addLog', @_id, start, end)
