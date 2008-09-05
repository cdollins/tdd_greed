def score(roll)
  accum = 0
  
  raise ArgumentError unless roll.is_a? Array
  raise RuntimeError unless roll.any?{|r| r.is_a? Fixnum }
  raise RuntimeError if roll.any?{|r| r < 1}
  
  accum += 100 if single_detector(roll, 1)
  accum += 50 if single_detector(roll, 5)

  (1..6).each do |num|
    if roll.find_all{|n| num == n}.length >= 3
      score = num == 1 ? 1000 : 100      
      accum += score * num
    end
  end

  accum
end 

def single_detector(roll, number)
  roll.find_all{|n| n == number}.length == 1
end
