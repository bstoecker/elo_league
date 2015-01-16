require 'rails_helper'

describe EloTeamValue do
  describe '.update_for' do
    let(:today) { Date.new(2014) }
    let(:team1) { FactoryGirl.build :team }
    let(:team2) { FactoryGirl.build :team }
    before do
      allow(Date).to receive(:today).and_return(today)
      team1.save!
      team2.save!
      FactoryGirl.create :elo_team_value,
                         date: today + 1,
                         value: 1500,
                         team: team1
    end

    it 'creates a new value, when no value exist and updates existing values' do
      allow(Date).to receive(:today).and_return(today + 1)
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
      elos_before = team1.users.map { |u| u.current_elo.value }
      EloTeamValue.update_for(team1, team1, 1, 0, Date.today)
      team1.users.each.with_index do |user, i|
        expect(user.current_elo).to be > elos_before[i]
      end
    end

    it 'decreases the elo value of team2 users' do
      allow(Date).to receive(:today).and_return(today + 1)
      elos_before = team2.users.map { |u| u.current_elo.value }
      EloTeamValue.update_for(team1, team2, 1, 0, Date.today)
      team2.users.each.with_index do |user, i|
        expect(user.current_elo).to be < elos_before[i]
      end
    end
  end
end
