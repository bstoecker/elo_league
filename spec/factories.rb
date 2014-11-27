FactoryGirl.define do
  factory :elo_team_value do
    league_id     { FactoryGirl.build :league }
    date          { Date.today }
    value         { 1500 }
  end

  factory :team do
    league        { FactoryGirl.build :league }
    name          { 'Foo Fighters' }
  end

  factory :user do
    first_name          { 'Kenny' }
    last_name           { 'McCormack' }
    nick_name           { 'Kenny' }
    teams               { [] }
    league_id           { FactoryGirl.build :league }
  end

  factory :league do
    name        { 'Elo League' }
    describtion { 'First test league' }
  end

  factory :result do
    league      { FactoryGirl.build :league }
    score1      { 1 }
    score2      { 0 }
    team_id1    { 1 }
    team_id2    { 2 }
    date        { Date.today }
  end
end
