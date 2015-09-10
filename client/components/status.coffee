Template.status.helpers
  'statStyle': () ->
    current = share.getUserStatus(@_id).status
    switch current
      when "IN" then result = 'success'
      when "NEVER" then result = 'info'
      else result = ''
    return result

  'stat': () ->
    current = share.getUserStatus(@_id)
    time = current.time.toLocaleTimeString()
    switch current.status
      when "IN" then result = 'Signed in since ' + time
      when "OUT" then result = 'Signed out'
      when "NEVER" then result = 'Never signed in'
    return result

  'in': () ->
    current = share.getUserStatus(@_id)
    return current.status == "IN"

Template.status.events
  'click .sign-out': (e) ->
    Meteor.call('signOut', @_id)

  'click .sign-in': (e) ->
    Meteor.call('signIn', @_id)

  'click .delete-user': () ->
    if confirm('Are you SURE you want to delete ' + @name + '?')
      Meteor.call('removeUser', @_id)
