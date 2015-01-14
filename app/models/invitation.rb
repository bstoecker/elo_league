class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  def inviter
    User.find(inviter_id)
  end

  def confirm
    destroy && return if league.users.include?(user)
    league.users << user
    league.save
    destroy
  end
end
