EloLeague.User = DS.Model.extend
  first_name: DS.attr('string')
  last_name: DS.attr('string')
  nick_name: DS.attr('string')
  current_elo_value: DS.attr('number')
  league: DS.belongsTo('league')
