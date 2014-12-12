class InvitationSerializer < ActiveModel::Serializer
  attributes :user_id, :league_id, :inviter_id, :created_at
end
