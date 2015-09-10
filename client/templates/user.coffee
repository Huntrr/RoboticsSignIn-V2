Template.user.helpers
  'logs': () -> Logs.find({userId: @_id}, {sort: {start: -1}})
  'numLogs': () -> Logs.find({userId: @_id}).count()
