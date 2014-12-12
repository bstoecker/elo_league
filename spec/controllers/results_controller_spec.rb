require 'rails_helper'

RSpec.describe Api::ResultsController, type: :controller do

  before { allow(controller).to receive(:authenticate_user!) }

  describe 'GET index' do
    it 'assigns @result' do
      league1 = FactoryGirl.create :league, name: 'First league'
      league2 = FactoryGirl.create :league, name: 'Second league'
      team1 = FactoryGirl.create :team, name: 'Team1', league: league1
      team2 = FactoryGirl.create :team, name: 'Team2', league: league1
      team3 = FactoryGirl.create :team, name: 'Team1', league: league2
      team4 = FactoryGirl.create :team, name: 'Team2', league: league2
      result = FactoryGirl.create :result,
                                  league: league1,
                                  team_id1: team1.id,
                                  team_id2: team2.id
      FactoryGirl.create :result,
                         league: league2,
                         team_id1: team3.id,
                         team_id2: team4.id
      get :index, league_id: result.league.id
      expect(assigns(:results)).to eq([result])
    end

    let(:users) do
      [
        (FactoryGirl.build :user, leagues: [league]),
        (FactoryGirl.build :user, leagues: [league]),
        (FactoryGirl.build :user, leagues: [league]),
        (FactoryGirl.build :user, leagues: [league])
      ]
    end

    let(:league) { FactoryGirl.build :league }

    it 'accepts posts' do
      league.save!
      users.each(&:save!)
      params = {
        date: Date.today,
        score1: 1,
        score2: 0
      }
      post :create,
           league_id: league.id,
           result: params,
           user_ids1: users[0..1],
           user_ids2: users[2..3],
           format: :json

      expect(response.code).to eq '200'
    end
  end

end
