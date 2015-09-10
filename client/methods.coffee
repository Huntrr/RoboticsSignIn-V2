share.getUserStatus = (userId) ->
  latestLog = Logs.findOne({userId: userId}, {sort: {start: -1}})
  if latestLog?
    if not latestLog.end?
      return {status: "IN", time: latestLog.start}
    else
      return {status: "OUT", time: latestLog.end}
  else
    user = Users.findOne({_id: userId})
    if user?
      return {status: "NEVER", time: user.createdAt}
    else return {status: "NEVER", time: new Date}

share.getTimeOfLog = (log) ->
  start = log.start
  end = log.end ? start

  diff = end.getTime() - start.getTime()
  return (diff / 1000) # returns seconds

share.parseTime = (seconds) ->
  seconds = Math.floor(seconds)
  minutes = Math.floor(seconds / 60)
  seconds = seconds % 60
  hours = Math.floor (minutes / 60)
  minutes = minutes % 60
  return hours + " hours, " + minutes + " minutes, " + seconds + " seconds"
