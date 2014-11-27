class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :nick_name, :current_elo_value

  def id
    object.id.to_s
  end

  def current_elo_value
    object.current_elo.value
  end
end
