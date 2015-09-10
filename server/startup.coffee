Meteor.startup () ->
  Users._ensureIndex {
    'name': 'text'
  }

  if Meteor.users.find({}).count() < 1
    Accounts.createUser {username: 'log', password: 'password'}
    Accounts.createUser {username: 'admin', password: 'securepassword', email: 'admin'}
