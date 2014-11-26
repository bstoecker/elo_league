class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :league_id
      t.float :score1
      t.float :score2
      t.integer :team_id1
      t.integer :team_id2

      t.timestamps
    end
  end
end
