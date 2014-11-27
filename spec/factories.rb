FactoryGirl.define do
  factory :elo_team_value do
    league_id     { 1 }
    date          { Date.new(2014) }
    value         { 1500 }
  end

  factory :team do
    league_id     { 1 }
    name          { 'Foo Fighters' }
  end

  factory :user do
    first_name          { 'Kenny' }
    last_name           { 'McCormack' }
    nick_name           { 'Kenny' }
    teams               { [] }
    league_id           { FactoryGirl.create :league }
  end

  factory :league do
    name        { 'Elo League' }
    describtion { 'First test league' }
  end
end
