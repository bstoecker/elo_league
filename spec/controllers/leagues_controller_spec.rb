require 'rails_helper'

RSpec.describe LeaguesController, type: :controller do
  let(:user) { FactoryGirl.build :user }

  before do
    user.save!
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET index' do
    it 'assigns @league' do
      league = FactoryGirl.create :league
      get :index
      expect(assigns(:leagues)).to eq([league])
    end
  end

  describe 'POST create' do
    it 'creates a new league' do
      FactoryGirl.create :league, name: 'Some other name'
      post :create,
           league: {
             name: 'The League of Extraordinary Gentlemen',
             describtion: 'yay'
           }
      league = League.find_by(name: 'The League of Extraordinary Gentlemen')
      expect(league).not_to be_nil
      expect(league.users).to eq [user]
    end
  end
end
