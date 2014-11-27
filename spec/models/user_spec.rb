require 'rails_helper'

describe User do

  let(:today) { Date.new(2014) }

  describe '.update_users_by_team' do
    let(:team) { FactoryGirl.build :team }
    let(:users) do
      [
        (FactoryGirl.build :user, teams: [team], nick_name: 'K1'),
        (FactoryGirl.build :user, teams: [team], nick_name: 'K2')
      ]
    end

    before do
      allow(Date).to receive(:today).and_return(today)
      team.save!
      users.each(&:save!)
      allow(Date).to receive(:today).and_return(today + 1)
      users.first.elo_user_values.create!(date: Date.today, value: 1510)
    end

    it 'creates or updates user elo' do
      expect do
        User.update_users_by_team(team, 5, Date.today)
      end.to change { EloUserValue.count }.from(3).to(4)
    end

    it 'updates elo values correctly' do
      User.update_users_by_team(team, 5, Date.today)
      expect(users.first.current_elo.value).to eq 1515
      expect(users.second.current_elo.value).to eq 1505
      expect(users.first.current_elo.date).to eq Date.today
      expect(users.second.current_elo.date).to eq Date.today
    end
  end
end
