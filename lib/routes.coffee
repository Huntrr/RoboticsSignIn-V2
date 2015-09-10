Router.configure {
  layoutTemplate: 'body'
  notFoundTemplate: 'notFound'
}

Router.route '/', () ->
  @render 'home'
, name: 'home'

Router.route '/user/:_id', () ->
  @render 'user', data: () -> Users.findOne _id: @params._id
, name: 'user.show'

Router.route '/login', () ->
  @render 'login'
, name: 'login'

# check for login first
Router.onBeforeAction () ->
  if !Meteor.user() && !Meteor.loggingIn()
    @redirect '/login'
  else
    @next();
, except: ['login']
