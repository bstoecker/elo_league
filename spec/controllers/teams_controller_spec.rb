require 'rails_helper'

RSpec.describe Api::TeamsController, :type => :controller do

  describe "GET index" do
    it "assigns @teams" do
      league = FactoryGirl.create :league
      other_league = FactoryGirl.create :league
      team = FactoryGirl.create :team, league: league
      other_team = FactoryGirl.create :team, league: other_league
      get :index, league_id: league.id
      expect(assigns(:teams)).to eq([team])
    end
  end
end
