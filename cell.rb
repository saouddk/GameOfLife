class Cell
  attr_accessor :game, :state, :x, :y

  def initialize(game, x=0, y=0, state = :dead)
    @game = game
    @x = x
    @y = y
    @state = state

    @game.grid << self
  end

  def live_neighbors
    neighbors_arr = []
    @game.grid.each do |cell|
      next if cell == self || cell.state == :dead

      #Neighbor in the west
      if cell.x == @x-1 && cell.y == @y
        neighbors_arr << cell
      elsif cell.x == @x+1 && cell.y == @y #neighbor in the east
        neighbors_arr << cell
      elsif cell.x == @x && cell.y == @y + 1 # neighbor in the north
        neighbors_arr << cell
      elsif cell.x == @x && cell.y == @y - 1 # neighbors in the south
        neighbors_arr << cell
      elsif cell.x == @x-1 && cell.y == @y+1 # north-west
        neighbors_arr << cell
      elsif cell.x == @x+1 && cell.y == @y +1 # north-east
        neighbors_arr << cell
      elsif cell.x == @x-1 && cell.y == @y-1 # south-west
        neighbors_arr << cell
      elsif cell.x == @x+1 && cell.y == @y-1 # south-east
        neighbors_arr << cell
      end
    end

    neighbors_arr
  end

  def dead!
    @state = :dead
  end

  def live!
    @state = :live
  end

  def alive?
    @state == :live
  end

end