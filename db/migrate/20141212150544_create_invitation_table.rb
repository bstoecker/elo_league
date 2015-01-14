class CreateInvitationTable < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :league_id
      t.integer :inviter_id

      t.timestamps
    end
  end
end
