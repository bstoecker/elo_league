class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :name, :describtion, :links

  def links
    { users: "api/leagues/#{object.id}/users" }
  end
end
