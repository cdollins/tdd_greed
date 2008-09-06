
require 'rubygems'
require 'test/unit'
require 'shoulda'

require 'lib/greed/score.rb'

def assert_score(score, roll)
  assert_equal(score, Score.new(roll).points)
end

def assert_remaining_dice(num_dice, roll)
  assert_equal(num_dice, Score.new(roll).dice_remaining)
end

class TestGreed < Test::Unit::TestCase
  
  context "with valid data" do
    
    should "return 0 score for empty die set" do
      assert_score(0, [])      
    end
    
    context "a single die" do
      should "score 100 if 1" do
        assert_score(100, [1])
      end    
      should "score 50 if 5" do        
        assert_score(50, [5])
      end
    end
    
    should "score triples as 100 * the triple unless it is 1" do
      assert_score(300, [3,3,3])
      assert_score(400, [4,4,4])
      assert_score(500, [5,5,5])
    end

    should "score triple 1's as 1000" do
      assert_score(1000, [1,1,1])
    end

    should "score 3,4,2,4,4 as 400" do
      assert_score(400, [3,4,2,4,4])
    end

    should "score 4,4,4,4,1 as 400" do
      assert_score(500, [4,4,4,4,1])
    end

    should "score 2,1,1,3,1as 1000" do
      assert_score(1000, [2,1,1,3,1])
    end
    
    should "score 3,5,2,3,3 as 350 " do
      assert_score(350, [3,5,2,3,3])
    end
    
    should "score 1,1,1,1,1 as 1200 " do
      assert_score(1200, [1,1,1,1,1])
    end
    
    should "score 5,5,5,5,5 as 600" do 
      assert_score(600, [5,5,5,5,5])
    end
  end
  
  context "with invalid data" do
    should "raise an ArgumentError if an array is not passed" do
      assert_raise(ArgumentError) do
        Score.new("a bad string").points
      end
    end
    
    should "raise a RuntimeError if the array contains non integers" do
      assert_raise(RuntimeError) do
        Score.new(%w[a [3, 5, 2, 3, 3]b c 1 3]).points
      end
    end
    
    should "raise a RuntimeError if the array contains negative numbers" do
      assert_raise(RuntimeError) do
        Score.new([-1]).points
      end
    end
  end
  
  context "Dice returned in roll" do
    should "return 0 when no dice in roll" do
      assert_remaining_dice(0,[])
    end
    context "Single die" do
      should "return 1 when on a single non-scoring die" do
        assert_remaining_dice(1, [2])
      end
      should "return 0 dice on a single scoring die" do
        assert_remaining_dice(0, [5])
      end
    end
    context "Three dice" do 
      should "return 0 for triple" do 
        assert_remaining_dice(0, [1,1,1])
        assert_remaining_dice(0, [2,2,2])
        assert_remaining_dice(0, [5,5,5])
      end
    end
    context "Five dice" do
      should "return 2 from roll 2,1,1,3,1" do
        assert_remaining_dice(2,[2,1,1,3,1])
      end
      should "return 1 from roll 3,5,2,3,3" do
        assert_remaining_dice(1, [3,5,2,3,3])
      end
    end
    should "return 5 from roll 2,2,4,2,3" do
        assert_remaining_dice(5,[2,3,4,2,3])
    end
    should "return 0 from roll 5,5,5,5,5" do
        assert_remaining_dice(0,[5,5,5,5,5])
    end
  end
end
