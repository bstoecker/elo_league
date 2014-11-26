class Result < ActiveRecord::Base

  def self.add_result(new_result)
    transaction do
      new_result.save!
      new_result.update_elo
    end
  end

  private

  def update_elo
    team1 = Team.find_by(id: team_id1)
    team2 = Team.find_by(id: team_id1)
    Team.update_elos(
      date: date, team1: team1, team2: team2, score1: score1, score2: score2
    )
  end
end
