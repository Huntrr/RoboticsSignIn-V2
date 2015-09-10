Template.log.helpers
  'logStyle': () ->
    return ''

  'parseDate': () -> @start.toLocaleDateString()

  'parseStart': () -> @start.toLocaleTimeString()

  'parseEnd': () ->
    if @end?
      return @end.toLocaleTimeString()
    else
      return 'still signed in'

  'parseTime': () ->
    return share.parseTime(share.getTimeOfLog(@))

Template.log.events
  'click .delete-log': () ->
    Meteor.call('removeLog', @_id)
