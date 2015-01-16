require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  before { allow(controller).to receive(:authenticate_user!) }

  describe 'GET index' do
    it 'assigns @teams' do
      league = FactoryGirl.create :league
      other_league = FactoryGirl.create :league
      team = FactoryGirl.create :team, league: league
      FactoryGirl.create :team, league: other_league
      get :index, league_id: league.id
      expect(assigns(:teams)).to eq([team])
    end
  end
end
