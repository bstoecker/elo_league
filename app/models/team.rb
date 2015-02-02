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

  # Deprecated
  def average_elo_value
    number_of_users = users.any? ? users.size : 1
    users.map { |u| u.current_elo_value(league.id) }.sum / number_of_users
  end

  def self.find_by_users_or_create(league, user_ids)
    user_ids.sort!
    found_team = league.teams.find { |team| team.users.map(&:id) == user_ids }
    found_team || league.teams.create(
      name: '', users: user_ids.map { |id| User.find(id) }
    )
  end

  def results
    Result.where("team_id1 = #{id} OR team_id2 = #{id}")
  end

  private

  def create_initial_elo
    elo_team_values.create(
      value: 1500, league_id: league_id, date: Date.today
    )
  end
end
