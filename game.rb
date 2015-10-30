class Game
  attr_accessor :grid

  def initialize
    @grid = []
  end

  def step
    @grid.each do |cell|
      if cell.alive?
        if cell.live_neighbors.count < 2
          cell.dead!
        elsif cell.live_neighbors.count > 3
          cell.dead!
        end
      else
        if cell.live_neighbors.count == 3
          cell.live!
        end
      end
    end
  end

end