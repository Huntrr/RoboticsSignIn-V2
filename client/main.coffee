Meteor.subscribe('users')
Meteor.subscribe('logs')

Template.registerHelper 'year', () ->
  date = new Date()
  return date.getFullYear()

Template.registerHelper 'plural', (num) -> num != 1
Template.registerHelper 'singular', (num) -> num == 1
Template.registerHelper 'nonZero', (num) -> return num > 0
Template.registerHelper 'parseSeconds', (num) -> return share.parseTime num
Template.registerHelper 'admin', () -> 
  if Meteor.user()?
    if Meteor.user().emails?
      return Meteor.user().emails[0].address == "admin"
  return false
Template.registerHelper 'addS', (num) -> 
  return if num != 1 then 's' else ''

Template.body.events
  'click .log-out': (e) ->
    Meteor.logout()
    Router.go('login')

Meteor.startup () ->
  Geolocation.currentLocation()
