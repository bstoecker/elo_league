class CreateEloTable < ActiveRecord::Migration
  def change
    create_table :elo_teams do |t|
      t.date :date
      t.float :value
      t.integer :league_id
      t.integer :team_id

      t.timestamps
    end

    create_table :elo_users do |t|
      t.date :date
      t.float :value
      t.integer :league_id
      t.integer :user_id

      t.timestamps
    end
  end
end
