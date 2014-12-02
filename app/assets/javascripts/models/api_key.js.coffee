EloLeague.ApiKeyAdapter = DS.LSAdapter.extend() ->
  namespace: 'emberauth-keys'

EloLeague.ApiKey = DS.Model.extend
  accessToken:     DS.attr('string'),
  user:            DS.belongsTo('user', { async: true })
