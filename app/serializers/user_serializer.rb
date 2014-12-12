class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :nick_name,
             :league_ids

  def league_id
    object.leagues.map(&:id)
  end

  def id
    object.id.to_s
  end
end
