Meteor.publish 'users', () ->
  return Users.find({})

Meteor.publish 'logs', () -> 
  return Logs.find({})
