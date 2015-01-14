require 'rails_helper'

describe Invitation do

  let(:league) { FactoryGirl.build :league }
  let(:inviter) { FactoryGirl.build :user }
  let(:user) { FactoryGirl.build :user }

  before do
    inviter.save!
    user.save!
    league.users << inviter
    league.save!
  end

  describe '#inviter' do
    let(:invitation) do
      Invitation.new(
        user_id: user.id, inviter_id: inviter.id, league_id: league.id
      )
    end
    it 'returns the inviter' do
      expect(invitation.inviter).to eq inviter
    end
  end

  describe '#confirm' do
    let(:invitation) do
      Invitation.new(
        user_id: user.id, inviter_id: inviter.id, league_id: league.id
      )
    end
    before { invitation.save! }
    it 'adds the user to the league' do
      league_id = invitation.league_id
      user_id = invitation.user_id
      invitation.confirm
      expect(League.find(league_id).users).to include user
      expect(User.find(user_id).leagues).to include league
    end
    it 'removes the invitation' do
      invitation.confirm
      id = invitation.id

      expect do
        Invitation.find(id)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
