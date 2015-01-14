require 'rails_helper'

describe 'invitations routes', type: :routing do

  before do
    @routes = EloLeague::Application.routes
    allow_any_instance_of(
      InvitationsController
    ).to receive(:authenticate_user!)
  end

  it 'routes to invitations#confirm with json' do
    expect(put: '/invitation/42.json').to route_to(
      controller: 'invitations',
      action: 'confirm',
      format: 'json',
      id: '42'
    )
  end

  it 'routes to invitations#create with html' do
    expect(post: '/invitations.json').to route_to(
      controller: 'invitations',
      action: 'create',
      format: 'json'
    )
  end

  it 'routes to invitations#destroy with html' do
    expect(delete: '/invitations/42.json').to route_to(
      controller: 'invitations',
      action: 'destroy',
      format: 'json',
      id: '42'
    )
  end

end
