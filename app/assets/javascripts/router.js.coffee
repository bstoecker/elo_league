# For more information see: http://emberjs.com/guides/routing/

EloLeague.Router.map ()->
  @resource 'sessions', ->
    @route('logout')
    @route('login')

  @resource 'users', ->
    @route('signup')
    @route('user', { path: '/user/:user_id' })

  @route('secret')

  @route 'home', path: '/'
  @resource 'leagues', path: '/leagues'
  @resource('league', path: '/leagues/:league_id')


