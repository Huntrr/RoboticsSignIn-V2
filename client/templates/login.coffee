Template.login.helpers
  'hasMessage': () -> (Session.get 'message')?
  'message': () -> Session.get 'message'

Template.login.events
  'submit .login-form': (e) ->
    e.preventDefault()

    username = e.target.username.value.toLowerCase()
    password = e.target.password.value

    Meteor.loginWithPassword username, password, (error) ->
      if error
        Session.set('message', error.reason || 'Unknown error')
      else
        Session.set('message', null)
        Router.go 'home'

    e.target.username.value = ''
    e.target.password.value = ''
