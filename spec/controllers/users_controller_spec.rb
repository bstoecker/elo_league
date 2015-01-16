require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before { allow(controller).to receive(:authenticate_user!) }

  describe 'GET index' do
    it 'assigns @users' do
      league = FactoryGirl.create :league
      other_league = FactoryGirl.create :league
      user = FactoryGirl.create :user, leagues: [league]
      FactoryGirl.create :user, leagues: [other_league]
      get :index, league_id: league.id
      expect(assigns(:users)).to eq([user])
    end
  end
end
