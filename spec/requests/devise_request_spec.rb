require 'rails_helper'

describe 'get /api/league/:id/users', type: :request do
  let(:user) do
    FactoryGirl.build :user,
                      first_name: 'Timo',
                      last_name: 'Horn',
                      nick_name: 'Tentakel',
                      password: '1.FC_Koeln'
  end
  before do
    user.save!
  end

  it 'put /users' do
    post_via_redirect user_session_path,
                      'user[email]' => user.email,
                      'user[password]' => user.password

    request_body = {
      user: {
        id: user.id,
        first_name: 'Miso',
        last_name: 'Brecko',
        nick_name: 'Terrier',
        current_password: '1.FC_Koeln',
        password: '#1.effZeh',
        password_confirmation: '#1.effZeh'
      }
    }
    put '/users', request_body
    updated_user = User.find(user.id)
    expect(updated_user.first_name).to eq request_body[:user][:first_name]
    expect(updated_user.last_name).to eq request_body[:user][:last_name]
    expect(updated_user.nick_name).to eq request_body[:user][:nick_name]
  end
end
