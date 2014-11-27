class Result < ActiveRecord::Base
  belongs_to :league
  default_scope -> { order('date ASC') }

  def self.build_from(league, user_ids1, user_ids2, score1, score2, date)
    team1 = Team.find_by_users_or_create(league, user_ids1)
    team2 = Team.find_by_users_or_create(league, user_ids2)
    params = {
      league: league, score1: score1, score2: score2, date: date,
      team_id1: team1.id, team_id2: team2.id
    }
    Result.add_result_by_params(params)
  end

  def self.add_result_by_params(params)
    transaction do
      result = Result.create!(params)
      result.update_elo
    end
  end

  def update_elo
    team1 = Team.find_by(id: team_id1)
    team2 = Team.find_by(id: team_id2)
    EloTeamValue.update_for(team1, team2, score1, score2, date)
  end
end
