require 'spec_helper'

describe 'Game of Life' do
  before do
    @game = Game.new
  end

  context 'Cell' do
    before do
      @cell = Cell.new(@game, 0, 0, :live)
    end

    describe '.state' do
      it 'is live' do
        expect(@cell.state).to eq(:live)
      end
    end

    describe '.x, .y' do
      it 'is located at (0, 0)' do
        expect(@cell.x).to eq(0)
        expect(@cell.y).to eq(0)
      end

      it 'is located at (1, 1)' do
        @cell.x = 1
        @cell.y = 1

        expect(@cell.x).to eq(1)
        expect(@cell.y).to eq(1)
      end
    end

    describe '.live_neighbors' do
      it 'has zero live neighbors' do
        expect(@cell.live_neighbors.count).to eq(0)
      end
    end

    describe '.dead!' do
      it 'is dead' do
        @cell.dead!
        expect(@cell.state).to eq(:dead)
      end
    end

    describe '.live!' do
      it 'is live' do
        @cell.live!
        expect(@cell.state).to eq(:live)
      end
    end

    describe '.alive?' do
      it 'returns true' do
        expect(@cell.alive?).to eq(true)
      end
    end

    describe '.live_neighbors' do

      it 'has a horizontal live neighbor in the west' do
        cell = Cell.new @game, -1, 0, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end

      it 'has a horizontal live neighbor in the east' do
        cell = Cell.new @game, 1, 0, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end

      it 'has a vertical live neighbor in the north' do
        cell = Cell.new @game, 0, 1, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end

      it 'has a vertical live neighbor in the south' do
        cell = Cell.new @game, 0, -1, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end

      it 'has a adjacent live neighbor in the north-west' do
        cell = Cell.new @game, -1, 1, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end

      it 'has a adjacent live neighbor in the north-east' do
        cell = Cell.new @game, 1, 1, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end

      it 'has a adjacent live neighbor in the south-west' do
        cell = Cell.new @game, -1, -1, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end

      it 'has a adjacent live neighbor in the south-east' do
        cell = Cell.new @game, 1, -1, :live
        expect(@cell.live_neighbors[0]).to eq(cell)
      end
    end

  end

  describe '.step' do
    context 'Any live cell with fewer than two live neighbours dies, as if caused by underpopulation' do
      before do
        @cell = Cell.new @game, 0, 0, :live
      end

      it 'is dead if 0 live neighbors' do
        @game.step
        expect(@cell.state).to eq(:dead)
      end

      it 'is dead if only 1 live neighbor' do
        cell2 = Cell.new @game, -1, 0, :live
        @game.step

        expect(@cell.state).to eq(:dead)
        expect(cell2.state).to eq(:dead)
      end
    end

    context 'Any live cell with more than three live neighbours dies, as if by overcrowding' do
      before do
        @cell = Cell.new @game, 0, 0, :live
      end

      it 'is dead if 4 live neighbors' do
        cell2 = Cell.new @game, -1, 0, :live
        cell3 = Cell.new @game, -1, -1, :live
        cell4 = Cell.new @game, 1, 0, :live
        cell5 = Cell.new @game, 0, -1, :live
        @game.step

        expect(@cell.state).to eq(:dead)
      end

      it 'is dead if 5 live neighbors' do
        cell2 = Cell.new @game, -1, 0, :live
        cell3 = Cell.new @game, -1, -1, :live
        cell4 = Cell.new @game, 1, 0, :live
        cell5 = Cell.new @game, 0, -1, :live
        cell5 = Cell.new @game, 0, 1, :live
        @game.step

        expect(@cell.state).to eq(:dead)
      end
    end

    context 'Any live cell with two or three live neighbours lives on to the next generation' do
      before do
        @cell = Cell.new @game, 0, 0, :live
      end

      it 'is live if 2 live neighbors' do
        cell2 = Cell.new @game, -1, 0, :live
        cell3 = Cell.new @game, 0, -1, :live
        @game.step

        expect(@cell.state).to eq(:live)
      end

      it 'is live if 3 live neighbors' do
        cell2 = Cell.new @game, -1, 0, :live
        cell3 = Cell.new @game, 0, -1, :live
        cell4 = Cell.new @game, 0, 1, :live
        @game.step

        expect(@cell.state).to eq(:live)
      end
    end

    context 'Any dead cell with exactly three live neighbours becomes a live cell' do
      before do
        @cell = Cell.new @game, 0, 0, :dead
        cell2 = Cell.new @game, -1, 0, :live
        cell3 = Cell.new @game, 0, -1, :live
        cell4 = Cell.new @game, 0, 1, :live
      end

      it 'becomes live with exactly 3 neighbors' do
        @game.step

        expect(@cell.state).to eq(:live)
      end

      it 'is not live with more than 3 neighbors' do
        cell5 = Cell.new @game, -1, 1, :live
        @game.step

        expect(@cell.state).to eq(:dead)
      end
    end
  end

end