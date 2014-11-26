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
end
