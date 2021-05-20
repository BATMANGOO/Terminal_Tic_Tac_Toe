require_relative '../lib/board'

describe Board do
  describe '#game_over?' do
    let(:board) { described_class.new }
    context 'winning conditions are met' do
      before do
        board.instance_variable_set(:@cells, ['x', 'o', 3, 4, 'o', 'x', 7, 'o', 'x'])
      end
      it 'returns true' do
        expect(board).to be_game_over
      end
    end

    context 'winning conditions are not met' do
      it 'returns false' do
        expect(board).not_to be_game_over
      end
    end
  end

  describe '#valid_move?' do
    let(:board) { described_class.new }
    context 'move is not valid' do
      before do
        board.instance_variable_set(:@cells, ['x', 'o', 3, 4, 'o', 'x', 7, 'o', 'x'])
      end
      it 'returns false' do
        invalid_move = board.valid_move?(1)
        expect(invalid_move).to be(false)
      end
    end

    context 'move is valid' do
      it 'returns true' do
        valid_move = board.valid_move?(3)
        expect(valid_move).to be(true)
      end
    end
  end

  describe '#full?' do
    let(:board) { described_class.new }
    context 'when board is full' do
      before do
        board.instance_variable_set(:@cells, ['x', 'o', 'x', 'o', 'o', 'x', 'x', 'x', 'o'])
      end
      it 'returns true' do
        expect(board).to be_full
      end
    end

    context 'when board is not full' do
      it 'returns false' do
        expect(board).not_to be_full
      end
    end
  end

  describe '#update_board' do
    let(:board) { described_class.new }
    context 'updating a position on the board' do
      before do
        player_choice = 1
        player_symbol = 'x'
        board.update_board(player_choice, player_symbol)
      end
      it 'returns the changed position' do
        updated_cells = board.cells
        comparison_cells = ['x', 2, 3, 4, 5, 6, 7, 8, 9]
        expect(updated_cells).to eq(comparison_cells)
      end
    end
  end
end