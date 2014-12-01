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
    name: 'The L.O.E.G',
    describtion: 'We are looking for the best of the best of the best, Sir!!!'
  )

  team1 = Team.create(name: 'Foofighters', league: league)
  team2 = Team.create(name: 'Bloody Marys', league: league)
  team3 = Team.create(name: 'Kamikaze', league: league)
  team4 = Team.create(name: 'Yay', league: league)

  user1 = User.create(
    first_name: 'Lekealem', last_name: 'Asong', nick_name: 'Leke', league: league
  )
  user2 = User.create(
    first_name: 'Frank', last_name: 'Trautmann', nick_name: 'Frank the Tank', league: league
  )
  user3 = User.create(
    first_name: 'Miguel', last_name: 'M', nick_name: 'Miguelsan', league: league
  )
  user4 = User.create(
    first_name: 'Andreas',
    last_name: 'Hoffmann',
    nick_name: 'AH 47',
    league: league
  )
  user5 = User.create(
    first_name: 'Bernhard', last_name: 'Stoecker', nick_name: 'Et Stoecki', league: league
  )
  user6 = User.create(
    first_name: 'David', last_name: 'Diemer', nick_name: 'David', league: league
  )
  user7 = User.create(
    first_name: 'Lars', last_name: 'Enstipp', nick_name: 'Lars', league: league
  )
  user8 = User.create(
    first_name: 'Martin', last_name: 'Eismann', nick_name: 'Meismann', league: league
  )



  team1.users = [user1, user2]
  team1.save!
  team2.users = [user3, user4]
  team2.save!
  team3.users = [user5, user6]
  team3.save!
  team4.users = [user7, user8]
  team4.save!
end