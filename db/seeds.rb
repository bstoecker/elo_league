# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record'

ActiveRecord::Base.transaction do
  league1 = League.create(
    name: 'The L.O.E.G',
    describtion: 'We are looking for the best of the best of the best, Sir!!!'
  )
  league2 = League.create(
    name: 'The Yay League',
    describtion: 'We are looking for the best of the best of the best, Sir!!!'
  )

  # team1 = Team.create(name: 'Foofighters', league: league1)
  # team2 = Team.create(name: 'Bloody Marys', league: league1)
  # team3 = Team.create(name: 'Kamikaze', league: league1)
  # team4 = Team.create(name: 'Yay', league: league1)

user1 = User.create(
    first_name: 'Lekealem',
    last_name: 'Asong',
    nick_name: 'Leke',
    email: 'leke@example.com',
    password: 'fooBar1234'
  )
  user2 = User.create(
    first_name: 'Frank',
    last_name: 'Trautmann',
    nick_name: 'Frank the Tank',
    email: 'frank@example.com',
    password: 'fooBar1234'
  )
  user3 = User.create(
    first_name: 'Philip',
    last_name: 'Arnreich',
    nick_name: 'Randomizer',
    email: 'philip@example.com',
    password: 'fooBar1234'
  )
  user4 = User.create(
    first_name: 'Andreas',
    last_name: 'Hoffmann',
    nick_name: 'AH 47',
    email: 'andreas@example.com',
    password: 'fooBar1234'
  )
  user5 = User.create(
    first_name: 'Bernhard',
    last_name: 'Stoecker',
    nick_name: 'Et Stoecki',
    email: 'bernhard@example.com',
    password: 'fooBar1234'
  )
  user6 = User.create(
    first_name: 'David',
    last_name: 'Diemer',
    nick_name: 'David',
    email: 'david@example.com',
    password: 'fooBar1234'
  )
  user7 = User.create(
    first_name: 'Lars',
    last_name: 'Enstipp',
    nick_name: 'Lars',
    email: 'lars@example.com',
    password: 'fooBar1234'
  )
  user8 = User.create(
    first_name: 'Jan',
    last_name: 'Zernisch',
    nick_name: 'Long Shot',
    email: 'jan@example.com',
    password: 'fooBar1234'
  )


  # user1 = User.create(
  #   first_name: 'Lekealem',
  #   last_name: 'Asong',
  #   nick_name: 'Leke',
  #   email: 'leke@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )
  # user2 = User.create(
  #   first_name: 'Frank',
  #   last_name: 'Trautmann',
  #   nick_name: 'Frank the Tank',
  #   email: 'frank@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )
  # user3 = User.create(
  #   first_name: 'Miguel',
  #   last_name: 'M',
  #   nick_name: 'Miguelsan',
  #   email: 'miguel@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )
  # user4 = User.create(
  #   first_name: 'Andreas',
  #   last_name: 'Hoffmann',
  #   nick_name: 'AH 47',
  #   email: 'andreas@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )
  # user5 = User.create(
  #   first_name: 'Bernhard',
  #   last_name: 'Stoecker',
  #   nick_name: 'Et Stoecki',
  #   email: 'bernhard@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )
  # user6 = User.create(
  #   first_name: 'David',
  #   last_name: 'Diemer',
  #   nick_name: 'David',
  #   email: 'david@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )
  # user7 = User.create(
  #   first_name: 'Lars',
  #   last_name: 'Enstipp',
  #   nick_name: 'Lars',
  #   email: 'lars@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )
  # user8 = User.create(
  #   first_name: 'Martin',
  #   last_name: 'Eismann',
  #   nick_name: 'Meismann',
  #   email: 'martin@example.com',
  #   password: 'fooBar1234',
  #   leagues: [league1, league2]
  # )



  # team1.users = [user1, user2]
  # team1.save!
  # team2.users = [user3, user4]
  # team2.save!
  # team3.users = [user5, user6]
  # team3.save!
  # team4.users = [user7, user8]
  # team4.save!
end
