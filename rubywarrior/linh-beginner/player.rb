class Player
  MAX_HEALTH = 20
  HEALTH_THRESHOLD = 15

  def initialize
    @health = MAX_HEALTH
  end

  def play_turn(warrior)
    if warrior.feel.empty?
      if not_well?(warrior) && is_safe?(warrior)
        warrior.rest!
      else
        warrior.walk!
      end
    else
      warrior.attack!
    end

    @health = warrior.health
  end

  def not_well?(warrior)
    warrior.health <= HEALTH_THRESHOLD
  end

  def is_safe?(warrior)
    warrior.health >= @health
  end
end
