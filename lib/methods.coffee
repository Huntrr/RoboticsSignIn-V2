Meteor.methods
  'addUser': (name) ->
    if Meteor.user()?
      check(name, String)
      user = Users.insert {
        name: name
        createdAt: new Date()
      }
  'signIn': (userId) ->
    if Meteor.user()?
      Logs.insert {
        userId: userId
        start: new Date()
        end: null
      }
  'signOut': (userId) ->
    if Meteor.user()?
      lastLog = Logs.findOne({userId: userId}, {sort: {start: -1}})
      if lastLog?
        Logs.update({_id: lastLog._id}, {$set: {end: new Date()}})
  'removeLog': (logId) ->
    if Meteor.user()?
      if Meteor.user().emails[0].address == 'admin'
        Logs.remove({_id: logId})
  'removeUser': (userId) ->
    if Meteor.user()?
      if Meteor.user().emails[0].address == 'admin'
        Users.remove({_id: userId})
  'addLog': (userId, start, end) ->
    if Meteor.user()?
      if Meteor.user().emails[0].address == 'admin'
        Logs.insert {
          userId: userId
          start: start
          end: end
        }
  'headHome': () ->
    if Meteor.user()?
      Logs.update({end: null}, {$set: {end: new Date()}}, {multi: true})
