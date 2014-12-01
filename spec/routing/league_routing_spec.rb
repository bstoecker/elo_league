require 'rails_helper'

describe 'leagues routes', type: :routing do

  before { @routes = EloLeague::Application.routes }
  it 'routes to leagues#index' do
    expect(get: '/api/leagues').to route_to(
      controller: 'api/leagues',
      action: 'index'
    )
  end
end
