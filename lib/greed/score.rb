class Score
  
  def initialize(roll)
    @roll = roll
  end 

  def points
    return 0 if @roll.length == 0
    points = 0
  
    raise ArgumentError unless @roll.is_a? Array
    raise RuntimeError unless @roll.any?{|r| r.is_a? Fixnum }
    raise RuntimeError if @roll.any?{|r| r < 1}
  
    points += 100 * single_detector(@roll, 1)
    points += 50 * single_detector(@roll, 5)

    triple_finder.each do |num|
      points += num == 1 ? 1000 : num * 100
    end
  
    points
  end
  
  def dice_remaining
    rem_dice = @roll.length
    return 0 if rem_dice == 0
    rem_dice -= 1 * single_detector(@roll, 1)
    rem_dice -= 1 * single_detector(@roll, 5)
    rem_dice -= 3 * triple_finder.length
  end
  
  def triple_finder
    dice = Array.new
    (1..6).each do |num|
      if @roll.find_all{|n| num == n}.length >= 3
        dice.push num
      end
    end
    dice
  end
  
  def single_detector(roll, number)
    count = roll.find_all{|n| n == number}.length
    count != -1? count % 3 : 0
  end
end
