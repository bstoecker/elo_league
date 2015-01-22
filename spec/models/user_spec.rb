require 'rails_helper'

describe User do
  let(:today) { Date.new(2014) }

  describe 'validations' do
    let(:user) { FactoryGirl.build :user }
    subject { user }
    pending { should validate_presence_of(:nick_name) }
  end

  describe '.update_users_by_team' do
    let(:league) { FactoryGirl.build :league }
    let(:team) { FactoryGirl.build :team, league: league }
    let(:users) do
      [
        (FactoryGirl.build :user, teams: [team], nick_name: 'K1'),
        (FactoryGirl.build :user, teams: [team], nick_name: 'K2')
      ]
    end

    before do
      allow(Date).to receive(:today).and_return(today)
      league.save!
      team.save!
      users.each(&:save!)
      users.first.elo_user_values.create!(
        date: Date.today, value: 1510, league: league
      )
      allow(Date).to receive(:today).and_return(today + 1)
    end

    it 'creates or updates user elo' do
      expect do
        User.update_users_by_team(team, 5, Date.today)
      end.to change { EloUserValue.count }.from(1).to(3)
    end

    it 'updates elo values correctly' do
      User.update_users_by_team(team, 5, Date.today)
      expect(users.first.current_elo_value(team.league_id)).to eq 1515
      expect(users.second.current_elo_value(team.league_id)).to eq 1505
    end
  end

  describe 'matches and results' do
    let(:league) { FactoryGirl.build :league }
    let(:team1) { FactoryGirl.build :team, league: league }
    let(:team2) { FactoryGirl.build :team, league: league }
    let(:team3) { FactoryGirl.build :team, league: league }
    let(:team4) { FactoryGirl.build :team, league: league }

    let(:user1) do
      FactoryGirl.build :user,
                        teams: [team1, team3],
                        nick_name: 'Team11andTeam31'
    end
    let(:user2) do
      FactoryGirl.build :user,
                        teams: [team1, team4],
                        nick_name: 'Team12andTeam41'
    end
    let(:user3) do
      FactoryGirl.build :user,
                        teams: [team2, team3],
                        nick_name: 'Team21andTeam32'
    end
    let(:user4) do
      FactoryGirl.build :user,
                        teams: [team2, team4],
                        nick_name: 'Team22andTeam42'
    end

    before do
      league.save!
      team1.save!
      team2.save!
      team3.save!
      team4.save!
      user1.save!
      user2.save!
      user3.save!
      user4.save!
    end

    it 'has no user having already played' do
      [user1, user2, user3, user4].each do |user|
        expect(user.matches(league.id)).to eq []
      end
    end

    it 'has no user having already won' do
      [user1, user2, user3, user4].each do |user|
        expect(user.won_matches(league.id)).to eq []
      end
    end

    it 'has no user having already lost' do
      [user1, user2, user3, user4].each do |user|
        expect(user.lost_matches(league.id)).to eq []
      end
    end

    it 'has no user having a draw' do
      [user1, user2, user3, user4].each do |user|
        expect(user.draw_matches(league.id)).to eq []
      end
    end

    it 'sums up the statistics correctly' do
      result1 = Result.create_from(
        user_ids1: team1.users.map(&:id),
        user_ids2: team2.users.map(&:id),
        score1: 5,
        score2: 0,
        league: league
      )
      result2 = Result.create_from(
        user_ids1: team3.users.map(&:id),
        user_ids2: team4.users.map(&:id),
        score1: 5,
        score2: 5,
        league: league
      )

      [user1, user2, user3, user4].each do |user|
        expect(
          user.matches(league.id).sort_by(&:id)
        ).to eq [result1, result2].sort_by(&:id)
      end
      expect(user1.won_matches(league.id)).to eq [result1]
      expect(user2.won_matches(league.id)).to eq [result1]
      expect(user3.won_matches(league.id)).to eq []
      expect(user4.won_matches(league.id)).to eq []

      expect(user1.lost_matches(league.id)).to eq []
      expect(user2.lost_matches(league.id)).to eq []
      expect(user3.lost_matches(league.id)).to eq [result1]
      expect(user4.lost_matches(league.id)).to eq [result1]

      expect(user1.draw_matches(league.id)).to eq [result2]
      expect(user2.draw_matches(league.id)).to eq [result2]
      expect(user3.draw_matches(league.id)).to eq [result2]
      expect(user4.draw_matches(league.id)).to eq [result2]
    end
  end
end
