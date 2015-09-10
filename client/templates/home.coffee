Template.home.helpers
  'personName': () -> Session.get 'personName'
  'isName': () ->
    if Session.get 'personName'
      return Session.get('personName').length > 0
    return false
  'users': () ->
    if Session.get('personName')?
      users = Users.find(name: {$regex: '.*'+Session.get('personName')+'.*', $options: 'i' })
    else
      users = Users.find({})

    users = users.fetch()
    return _.sortBy users, (user) ->
      console.log user.curStatus
      return ((1000000000 * user.curStatus()) + user.seasonTime())*-1;

Template.home.events 
  'input #personName': (e) ->
    Session.set 'personName', $('#personName').val()
  'click #add-user': (e) ->
    name = Session.get 'personName'
    console.log name
    if name.length > 1
      Meteor.call('addUser', name)

      $('#personName').val('')
      Session.set 'personName', ''
  'click #head-home': (e) ->
    if confirm('Are you sure you want to sign everyone out for the day?')
      Meteor.call('headHome')
