require 'rubygems'
require 'test/unit'
require 'shoulda'

require 'score'

def assert_score(score, roll)
  assert_equal(score, score(roll))
end

class TestGreed < Test::Unit::TestCase

  context "with valid data" do    
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

    should "score 2,1,1,3,1" do
      assert_score(1000, [2,1,1,3,1])
    end
  end
  
  context "with invalid data" do
    should "raise an ArgumentError if an array is not passed" do
      assert_raise(ArgumentError) do
        score("a bad string")
      end
    end
    
    should "raise a RuntimeError if the array contains non integers" do
      assert_raise(RuntimeError) do
        score(%w[a b c 1 3])
      end
    end
    
    should "raise a RuntimeError if the array contains negative numbers" do
      assert_raise(RuntimeError) do
        score([-1])
      end
    end
  end
end
