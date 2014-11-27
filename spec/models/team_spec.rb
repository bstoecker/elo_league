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
end
