require 'rails_helper'

RSpec.describe Api::LeaguesController, :type => :controller do

  describe "GET index" do
    it "assigns @league" do
      league = FactoryGirl.create :league
      get :index
      expect(assigns(:leagues)).to eq([league])
    end
  end

  describe "POST create" do
    it "creates a new league" do
      league = FactoryGirl.create :league
      post :create,
           league: {
             name: 'The League of Extraordinary Gentlemen',
             describtion: 'yay'
           }
      expect(
        League.find_by(name: 'The League of Extraordinary Gentlemen')
      ).not_to be_nil
    end
  end

end
