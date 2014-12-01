# For more information see: http://emberjs.com/guides/routing/

EloLeague.Router.map ()->
  @route 'home', path: '/'
  @resource 'leagues', path: '/leagues'
  @resource('league', path: '/leagues/:league_id')


