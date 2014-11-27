require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  describe 'GET index' do
    it 'assigns @users' do
      league = FactoryGirl.create :league
      other_league = FactoryGirl.create :league
      user = FactoryGirl.create :user, league: league
      FactoryGirl.create :user, league: other_league
      get :index, league_id: league.id
      expect(assigns(:users)).to eq([user])
    end
  end
end
