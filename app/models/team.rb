class Team < ActiveRecord::Base
  has_many :elo_team_values
  belongs_to :league
  has_and_belongs_to_many :users
  after_create :create_initial_elo

  def create_or_update_elo(new_elo_value, date)
    item = EloTeamValue.find_or_initialize_by(team: self, date: date)
    item.update_attributes(value: new_elo_value)
  end

  def current_elo
    elo_team_values.last
  end

  private

  def create_initial_elo
    elo_team_values.create(
      value: 1500, league_id: league_id, date: Date.today
    )
  end
end
