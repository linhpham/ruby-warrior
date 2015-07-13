class Player
  def play_turn(warrior)
    if warrior.feel.empty?
      if not_well?(warrior)
        warrior.rest!
      else
        warrior.walk!
      end
    else
      warrior.attack!
    end
  end

  def not_well?(warrior)
    warrior.health <= 10
  end
end
