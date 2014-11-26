require 'rails_helper'

describe Elo do

  describe '#new_elo1 #new_elo2' do
    it 'increases the elo value, when first player wins' do
      elo = Elo.new(
        score1: 1,
        score2: 0,
        current_elo1: 1500,
        current_elo2: 1500
      )
      expect(elo.new_elo1).to be > 1500
      expect(elo.new_elo2).to be < 1500
    end

    it 'respects the win probability within scoring' do
      elo = Elo.new(
        score1: 1,
        score2: 0,
        current_elo1: 1500,
        current_elo2: 1500
      )
      new_elo1 = elo.new_elo1
      new_elo2 = elo.new_elo2
      elo = Elo.new(
        score1: 0,
        score2: 1,
        current_elo1: new_elo1,
        current_elo2: new_elo2
      )
      expect(elo.new_elo1).to be < 1500
      expect(elo.new_elo2).to be > 1500
    end

    it 'weights the elo values by scores' do
      elo1 = Elo.new(
        score1: 5,
        score2: 0,
        current_elo1: 1500,
        current_elo2: 1500
      )
      elo2 = Elo.new(
        score1: 5,
        score2: 1,
        current_elo1: 1500,
        current_elo2: 1500
      )
      expect(elo1.new_elo1).to be > elo2.new_elo1
      expect(elo1.new_elo2).to be < elo2.new_elo2

    end
  end

end
