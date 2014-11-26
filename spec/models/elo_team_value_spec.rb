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
      before_count = EloTeamValue.count
      expect do
        EloTeamValue.update_for(
          team1: team1, score1: 1, team2: team2, score2: 0, date: Date.new(2014)
        )
      end.to change { EloTeamValue.count }
        .from(before_count)
        .to(EloTeamValue.count + 1)
    end
  end

end
