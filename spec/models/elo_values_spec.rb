require 'rails_helper'

describe EloValues do
  let(:league) { FactoryGirl.build :league }
  let(:users) do
    (1..6).map do |i|
      FactoryGirl.build(:user, nick_name: "USER#{i}", leagues: [league])
    end
  end

  before do
    allow(Date).to receive(:today).and_return(Date.new(2015, 1, 18))
    league.save!
    users.each(&:save!)
    @result_params = [
      {
        league: league,
        user_ids1: [users[0].id, users[1].id],
        user_ids2: [users[2].id, users[3].id],
        score1: 4,
        score2: 0
      },
      {
        league: league,
        user_ids1: [users[4].id, users[5].id],
        user_ids2: [users[0].id, users[1].id],
        score1: 4,
        score2: 2
      },
      {
        league: league,
        user_ids1: [users[2].id, users[3].id],
        user_ids2: [users[4].id, users[5].id],
        score1: 4,
        score2: 0
      },
      {
        league: league,
        user_ids1: [users[0].id, users[2].id],
        user_ids2: [users[3].id, users[5].id],
        score1: 4,
        score2: 0
      },
      {
        league: league,
        user_ids1: [users[3].id, users[5].id],
        user_ids2: [users[1].id, users[4].id],
        score1: 4,
        score2: 0
      },
      {
        league: league,
        user_ids1: [users[1].id, users[4].id],
        user_ids2: [users[0].id, users[2].id],
        score1: 4,
        score2: 0
      }
    ]
    @result_params.each.with_index do |params, i|
      if i == 3
        allow(Date).to receive(:today).and_return(Date.new(2015, 1, 19))
      end
      Result.create_from(params)
    end
  end

  describe 'test setup' do
    it 'has 6 results in db' do
      expect(Result.all.size).to eq @result_params.size
    end
  end

  describe '#for_user' do
    it 'create the right elo_values' do
      elo_values = EloValues.new(league)
      users.each do |user|
        result = elo_values.for_user(user)
        expect(result.last.date).to eq Date.today
      end
    end
  end
end
