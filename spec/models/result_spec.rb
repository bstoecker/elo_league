require 'rails_helper'

describe Result do

  let(:league) { FactoryGirl.build :league }
  let(:users) do
    4.times.map do |i|
      FactoryGirl.build :user, nick_name: "#{i}", leagues: [league]
    end
  end
  let(:team) do
    FactoryGirl.build :team,
                      name: 'Foofighters',
                      users: users[0..1],
                      league: league
  end

  describe ''

  before do
    league.save!
    users.each(&:save!)
    team.save!
  end

  it 'creates an additional team when one team cannot be found' do
    user_ids1 = users[0..1].map(&:id)
    user_ids2 = users[2..3].map(&:id)
    expect do
      Result.create_from(
        league: league,
        user_ids1: user_ids1,
        user_ids2: user_ids2,
        score1: 1,
        score2: 0,
        date: Date.today + 1
      )
    end.to change { league.teams.count }.from(1).to(2)
  end

  it 'increases the elo value of existing team' do
    user_ids1 = users[0..1].map(&:id)
    user_ids2 = users[2..3].map(&:id)
    elo_before = team.current_elo.value
    Result.create_from(
        league: league,
        user_ids1: user_ids1,
        user_ids2: user_ids2,
        score1: 1,
        score2: 0,
        date: Date.today + 1
      )
    expect(team.current_elo.value).to be > elo_before
  end

  it 'decreases the elo of the new created team' do
    user_ids1 = users[0..1].map(&:id)
    user_ids2 = users[2..3].map(&:id)
    Result.create_from(
        league: league,
        user_ids1: user_ids1,
        user_ids2: user_ids2,
        score1: 1,
        score2: 0,
        date: Date.today + 1
      )
    other_team = Team.find do |team|
      team.users == users[2..3]
    end
    expect(other_team.current_elo.value).to be < 1500
  end

  it 'increases the elo values of existing team users' do
    user_ids1 = users[0..1].map(&:id)
    user_ids2 = users[2..3].map(&:id)
    elo_before = team.users.map { |user| user.current_elo(league.id) }
    Result.create_from(
        league: league,
        user_ids1: user_ids1,
        user_ids2: user_ids2,
        score1: 1,
        score2: 0,
        date: Date.today + 1
      )
    team.users.each.with_index do |user, i|
      expect(user.current_elo(league.id)).to be > elo_before[i]
    end
  end

  it 'decreases the elo of the new created team' do
    user_ids1 = users[0..1].map(&:id)
    user_ids2 = users[2..3].map(&:id)
    Result.create_from(
        league: league,
        user_ids1: user_ids1,
        user_ids2: user_ids2,
        score1: 1,
        score2: 0,
        date: Date.today + 1
      )
    other_team = Team.find do |team|
      team.users == users[2..3]
    end
    expect(other_team.current_elo.value).to be < 1500
  end

  it 'returns the result' do
    user_ids1 = users[0..1].map(&:id)
    user_ids2 = users[2..3].map(&:id)
    result = Result.create_from(
        league: league,
        user_ids1: user_ids1,
        user_ids2: user_ids2,
        score1: 1,
        score2: 0,
        date: Date.today + 1
      )
    expect(result).to eq Result.all.last
  end
end
