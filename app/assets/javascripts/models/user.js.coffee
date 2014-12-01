EloLeague.User = DS.Model.extend
  first_name:            DS.attr('string')
  last_name:             DS.attr('string')
  nick_name:             DS.attr('string')
  email:                 DS.attr('string'),
  password:              DS.attr('string'),
  password_confirmation: DS.attr('string'),
  apiKeys:               DS.hasMany('apiKey'),
  errors:                {}
  current_elo_value:     DS.attr('number')
