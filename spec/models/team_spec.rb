require 'rails_helper'

describe Team do
  let(:today) { Date.new(2014) }

  describe '#create_or_update_elo' do
    let(:team) { FactoryGirl.build :team }

    before do
      allow(Date).to receive(:today).and_return(today)
      team.save!
    end

    it 'creates a new EloTeamValue, when date does not exist' do
      expect do
        team.create_or_update_elo(1510, Date.today + 1)
      end.to change { EloTeamValue.count }.from(1).to(2)
    end

    it 'updates an existing EloTeamValue, when date exists' do
      expect do
        team.create_or_update_elo(1510, Date.today)
      end.to_not change { EloTeamValue.count }.from(1)
    end

    it 'updates to the right values after creating a new record' do
      team.create_or_update_elo(1510, Date.today + 1)
      expect(team.current_elo.value).to eq 1510
    end

    it 'updates to the right values after updating a record' do
      team.create_or_update_elo(1510, Date.today)
      expect(team.current_elo.value).to eq 1510
    end
  end

  describe 'average_elo' do
    let(:league) { FactoryGirl.build :league }
    let(:team) { FactoryGirl.build :team, league: league }
    let(:user1) { FactoryGirl.build :user }
    let(:user2) { FactoryGirl.build :user }
    let(:elo_value_user1) do
      FactoryGirl.build :elo_user_value,
                        value: 1490, user: user1, league: league
    end
    let(:elo_value_user2) do
      FactoryGirl.build :elo_user_value,
                        value: 1530, user: user2, league: league
    end

    before do
      team.users = [user1, user2]
      [team, user1, user2, elo_value_user1, elo_value_user2].each(&:save!)
    end
    it 'returns the right value' do
      expect(team.average_elo_value).to eq 1510.0
    end
  end
end
