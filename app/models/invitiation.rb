class Invitation < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :league, dependent: :destroy

  def inviter
    User.find(inviter_id)
  end
end
