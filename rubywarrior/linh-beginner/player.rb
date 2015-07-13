class Player
  MAX_HEALTH = 20
  HEALTH_THRESHOLD = 8

  def initialize
    @health = MAX_HEALTH
    @direction = :forward
    @captured = false
  end

  def play_turn(warrior)
    @direction = think_direction(warrior, @direction, @captured)

    puts "last hp = #{@health}, current hp = #{warrior.health}"
    if warrior.feel(@direction).empty?
      if not_well?(warrior) && is_safe?(warrior)
        warrior.rest!
      else
        warrior.walk!(@direction)
      end
    elsif warrior.feel(@direction).captive?
      warrior.rescue!(@direction)
      @captured = true
    else
      warrior.attack!(@direction)
    end

    @health = warrior.health
  end

  def think_direction(warrior, direction, captured)
    if warrior.feel(direction).wall?
      return (direction == :forward ? :backward : :forward)
    end

    unless captured
      return :backward
    end

    if warrior.feel.empty? && is_low_hp?(warrior) && !is_safe?(warrior)
      return :backward
    end

    if is_well?(warrior) && is_safe?(warrior)
      return :forward
    end

    return :forward
  end

  def is_low_hp?(warrior)
    warrior.health <= HEALTH_THRESHOLD
  end

  def not_well?(warrior)
    !is_well?(warrior)
  end

  def is_well?(warrior)
    warrior.health >= MAX_HEALTH
  end

  def is_safe?(warrior)
    warrior.health >= @health
  end
end
