class EloTeamValue < ActiveRecord::Base
  default_scope -> { order('date ASC') }
  belongs_to :team, dependent: :destroy

  def self.update_for(team1, team2, score1, score2, date)
    average_elo_value_team1 = team1.average_elo_value
    average_elo_value_team2 = team2.average_elo_value
    elo = Elo.new(
      score1: score1,
      score2: score2,
      current_elo1: average_elo_value_team1,
      current_elo2: average_elo_value_team2
    )

    update_teams(team1, team2, elo, date)
    update_team_users(team1, team2, elo, date)
  end

  def self.update_teams(team1, team2, elo, date)
    elo_team1 = elo.new_elo1
    elo_team2 = elo.new_elo2
    team1.create_or_update_elo(elo_team1, date)
    team2.create_or_update_elo(elo_team2, date)
  end

  def self.update_team_users(team1, team2, elo, date)
    elo_diff_team1 = elo.elo_difference1
    elo_diff_team2 = elo.elo_difference2
    User.update_users_by_team(team1, elo_diff_team1, date)
    User.update_users_by_team(team2, elo_diff_team2, date)
  end
end
