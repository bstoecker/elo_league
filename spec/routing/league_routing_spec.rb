require 'rails_helper'

describe 'leagues routes', type: :routing do

  before do
    @routes = EloLeague::Application.routes
    allow_any_instance_of(
      Api::LeaguesController
    ).to receive(:authenticate_user!)
  end

  it 'routes to leagues#index' do
    expect(get: '/api/leagues').to route_to(
      controller: 'api/leagues',
      action: 'index',
      format: :json
    )
  end
end
