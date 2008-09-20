require 'rubygems'
require 'shoulda'
require 'test/unit'

require 'lib/greed/CompetentPlayer'


class CompetentPlayerTest < Test::Unit::TestCase
  #def setup
  #end
  context "with valid data" do
    context "Must Roll" do
      should "Roll less than this turn 300 when no score" do
        player = CompetentPlayer.new
        player.start_game
        player.start_turn(0,[400, 300])
        assert player.roll_again?(299,2)
      end
      
      should "Opponent has <= 3000 points" do 
        player = CompetentPlayer.new
        player.start_game
        player.start_turn(0,[2500, 3000])
        assert player.roll_again?(1000,2)
      end
    end
  end
end
