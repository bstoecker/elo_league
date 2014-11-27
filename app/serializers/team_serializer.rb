class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :current_elo_value, :league_id

  def id
    object.id.to_s
  end

  def league_id
    object.league_id.to_s
  end

  def current_elo_value
    object.current_elo.value
  end
end
