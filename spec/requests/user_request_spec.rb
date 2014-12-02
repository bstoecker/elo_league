require 'rails_helper'

describe 'get /api/league/:id/users', type: :request do

  before do
    allow_any_instance_of(UsersController).to receive(:authenticate_user!)
  end

  it 'returns the right users' do
    league = FactoryGirl.build :league

    users = [
      (
        FactoryGirl.build :user,
                          first_name: 'Esmeralda',
                          last_name: 'Dennsiewilja',
                          nick_name: 'Esmeralda',
                          leagues: [league]
      ),
      (
        FactoryGirl.build :user,
                          first_name: 'Rainsch',
                          last_name: 'Heisst',
                          nick_name: 'Rainsch',
                          leagues: [league]
      )
    ]

    users.each(&:save!)

    request_headers = { 'CONTENT_TYPE' => 'application/json' }
    get "/users.json?league_id=#{league.id}", request_headers
    expect(response.body).to be_json_eql(
      "{
        \"users\": [
          {
            \"id\": \"#{users.first.id}\",
            \"league_ids\": [#{league.id}],
            \"first_name\": \"Esmeralda\",
            \"last_name\": \"Dennsiewilja\",
            \"nick_name\": \"Esmeralda\",
            \"current_elo_value\": 1500.0
          },
          {
            \"id\": \"#{users.second.id}\",
            \"league_ids\": [#{league.id}],
            \"first_name\": \"Rainsch\",
            \"last_name\": \"Heisst\",
            \"nick_name\": \"Rainsch\",
            \"current_elo_value\": 1500.0
          }
        ]
      }"
    )
  end

end
