# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record'

ActiveRecord::Base.transaction do
  league = League.create(
    name: 'The League of Extraordinary Gentlemen',
    describtion: 'We are looking for the best of the best of the best, Sir!!!'
  )

  team1 = Team.create(name: 'Foofighters', league: league)
  team2 = Team.create(name: 'Bloody Marys', league: league)
  team3 = Team.create(name: 'Kamikaze', league: league)

  user1 = User.create(
    first_name: 'Bar', last_name: 'Foo', nick_name: 'Foobar', league: league
  )
  user2 = User.create(
    first_name: 'Baz', last_name: 'Foo', nick_name: 'Foobaz', league: league
  )
  user3 = User.create(
    first_name: 'Mary', last_name: 'Ann', nick_name: 'Maryann', league: league
  )
  user4 = User.create(
    first_name: 'Mary',
    last_name: 'Bloody',
    nick_name: 'Bloody Mary',
    league: league
  )
  user5 = User.create(
    first_name: 'Ah', last_name: 'Take', nick_name: 'Ahtake', league: league
  )
  user6 = User.create(
    first_name: 'Ki', last_name: 'Il', nick_name: 'KiIl', league: league
  )

  team1.users = [user1, user2]
  team1.save!
  team2.users = [user3, user4]
  team2.save!
  team3.users = [user5, user6]
  team3.save!
end