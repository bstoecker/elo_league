class RenameEloTables < ActiveRecord::Migration
  def change
    rename_table('elo_teams', 'elo_team_values')
    rename_table('elo_users', 'elo_user_values')
  end
end
