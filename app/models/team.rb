class Team < ActiveRecord::Base
  has_many :elo_team_values
  after_create :create_initial_elo

  private

  def create_initial_elo
    elo_team_values.create(
      value: 1500, league_id: league_id, date: Date.today
    )
  end
end
