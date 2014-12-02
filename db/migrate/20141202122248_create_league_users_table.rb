class CreateLeagueUsersTable < ActiveRecord::Migration
  def self.up
    create_table :leagues_users do |t|
      t.integer :user_id
      t.integer :league_id
    end

    add_index :leagues_users, [:league_id, :user_id]
  end

  def self.down
    drop_table :leagues_users
  end
end
