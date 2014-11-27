class AddLeagueIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :league_id, :integer

    add_index :users, [:league_id]
  end
end
