EloLeague.League = DS.Model.extend
  name: DS.attr('string')
  describtion: DS.attr('string')
  users: DS.hasMany('users')
