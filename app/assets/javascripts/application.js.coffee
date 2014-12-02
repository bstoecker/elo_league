#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require ember-simple-auth
#= require_self
#= require elo_league

# for more details see: http://emberjs.com/guides/application/
window.EloLeague = Ember.Application.create(
  rootElement: '#main-contents',
  LOG_TRANSITIONS:          true,
  LOG_TRANSITIONS_INTERNAL: true
)

EloLeague.ApplicationAdapter = DS.RESTAdapter.extend()
