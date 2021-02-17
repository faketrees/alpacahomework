def sluggish_octopus(fishies)
  fishies.each_with_index do |fish1, i1|
    max_length = true
    
    fishes.each_with_index do |fish2, i2|
      next if i1 == i2
      max_length = false if fish2.length > fish1.length
    end
    return fish1 if max_length
  end

end


class Array
  #dominant octopus
  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if count <= 1

    mid = self.length / 2
    sorted_left = self.take(mid).merge_sort(&prc)
    sorted_right = self.drop(mid).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end
    merged + left + right
  end
end


def dominant_octopus(fishies)
  prc = Proc.new { |x, y| y.length <=> x.length }
  fishies.merge_sort(&prc)[0]
end

def clever_octopus(fishies)
  biggest_fish = fishies.first
  fishies.each {|fish| biggest_fish = fish if fish.length > biggest_fish.length}
  biggest_fish
end

directions_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left", "left-up"]

def slow_dance(direction, tiles_array)
  tiles_array.each_with_index do |tile, index|
    return index if tile == direction
  end
end

#DDR
directions_hash = {"up" => 0, "right-up" => 1, "right"=> 2, "right-down" => 3, "down" => 4, "left-down" => 5, "left" => 6, "left-up" => 7}


def fast_dance(direction, tiles_hash)
  directions_hash[direction]
end