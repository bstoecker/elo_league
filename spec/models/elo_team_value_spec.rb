require 'rails_helper'

describe EloTeamValue do
  describe '.update_for' do
    let(:today) { Date.new(2014) }
    let(:league) { FactoryGirl.build :league }
    let(:team1) { FactoryGirl.build :team, league: league }
    let(:team2) { FactoryGirl.build :team, league: league }
    let(:user1) { FactoryGirl.build :user }
    let(:user2) { FactoryGirl.build :user }
    let(:elo_value_user1) do
      FactoryGirl.build :elo_user_value,
                        value: 1500, user: user1, league: league
    end
    let(:elo_value_user2) do
      FactoryGirl.build :elo_user_value,
                        value: 1500, user: user2, league: league
    end
    before do
      allow(Date).to receive(:today).and_return(today)
      team1.users = [user1]
      team2.users = [user2]
      [league, user1, user2, team1, team2].each(&:save!)
    end

    it 'creates a new value, when no value exist and updates existing values' do
      allow(Date).to receive(:today).and_return(today + 1)
      team_elo = FactoryGirl.build :elo_team_value,
                                   team: team1, date: Date.today
      team_elo.save!
      expect do
        EloTeamValue.update_for(team1, team2, 1, 0, Date.today)
      end.to change { EloTeamValue.count }
        .from(3)
        .to(4)
    end

    it 'increases the elo value of team1' do
      allow(Date).to receive(:today).and_return(today + 1)
      elo_before = team1.current_elo.value
      EloTeamValue.update_for(team1, team2, 1, 0, Date.today)
      expect(team1.current_elo.value).to be > elo_before
    end

    it 'decreases the elo value of team2' do
      allow(Date).to receive(:today).and_return(today + 1)
      elo_before = team2.current_elo.value
      EloTeamValue.update_for(team1, team2, 1, 0, Date.today)
      expect(team2.current_elo.value).to be < elo_before
    end

    it 'increases the elo value of team1 users' do
      allow(Date).to receive(:today).and_return(today + 1)
      elos_before = team1.users.map { |u| u.current_elo_value(league.id) }
      EloTeamValue.update_for(team1, team2, 1, 0, Date.today)
      team1.users.each.with_index do |user, i|
        expect(user.current_elo_value(league.id)).to be > elos_before[i]
      end
    end

    it 'decreases the elo value of team2 users' do
      allow(Date).to receive(:today).and_return(today + 1)
      elos_before = team2.users.map { |u| u.current_elo_value(league.id) }
      EloTeamValue.update_for(team1, team2, 1, 0, Date.today)
      team2.users.each.with_index do |user, i|
        expect(user.current_elo_value(league.id)).to be < elos_before[i]
      end
    end
  end
end
