class EloUpdater
  def update_elo_map(elo_map, result)
    current_average_elo_team1 = average_elo_for(result.team_id1, elo_map)
    current_average_elo_team2 = average_elo_for(result.team_id2, elo_map)

    elo = Elo.new(
      score1: result.score1,
      score2: result.score2,
      current_elo1: current_average_elo_team1,
      current_elo2: current_average_elo_team2
    )

    update_team_elos(elo_map, result, elo)
    update_user_elos(elo_map, result, elo)
  end

  private

  def average_elo_for(team_id, elo_map)
    team_members = Team.find(team_id).users
    points = team_members.reduce(0) do |a, user|
      a + elo_map[:user_elos][user.id].last.value
    end
    points / team_members.size.to_f
  end

  # Regarding Teams

  def update_team_elos(elo_map, result, elo)
    update_team_elo(elo_map, result.date, result.team_id1, elo.elo_difference1)
    update_team_elo(elo_map, result.date, result.team_id2, elo.elo_difference2)
  end

  def update_team_elo(elo_map, date, team_id, elo_diff)
    elements = elo_map[:team_elos][team_id]
    current_elo_value = elements ? elements.last.value : 1500.0

    elo_value = EloValue.new(
      date: date, value: current_elo_value + elo_diff
    )
    elo_map[:team_elos][team_id] ||= [elo_value]

    update_or_set_team_elo(elo_value, team_id, elo_map, date)
  end

  def update_or_set_team_elo(elo_value, team_id, elo_map, date)
    if elo_map[:team_elos][team_id].last.date == date
      elo_map[:team_elos][team_id][-1] = elo_value
    else
      elo_map[:team_elos][team_id] << elo_value
    end
  end

  # Regarding Users

  def update_user_elos(elo_map, result, elo)
    team1 = Team.find(result.team_id1)
    team2 = Team.find(result.team_id2)
    update_user_elos_of(team1.users, elo_map, result.date, elo.elo_difference1)
    update_user_elos_of(team2.users, elo_map, result.date, elo.elo_difference2)
  end

  def update_user_elos_of(users, elo_map, date, elo_diff)
    users.each do |user|
      elo_value = EloValue.new(
        date: date, value: elo_map[:user_elos][user.id].last.value + elo_diff
      )
      update_or_set_user_elo(user.id, elo_map, date, elo_value)
    end
  end

  def update_or_set_user_elo(user_id, elo_map, date, elo_value)
    if elo_map[:user_elos][user_id].last.date == date
      elo_map[:user_elos][user_id][-1] = elo_value
    else
      elo_map[:user_elos][user_id] << elo_value
    end
  end
end
