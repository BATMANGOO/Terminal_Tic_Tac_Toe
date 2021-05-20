require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do

  before do
    game.instance_variable_set(:@board, instance_double(Board))
  end

  describe '#combatents' do
    let(:game) { described_class.new }
    context 'when first player is created' do
      before do
        player_name = 'john'
        player_symbol = 'x'

        allow(game).to receive(:puts)
        allow(game).to receive(:create_player).with(1)
        allow(game).to receive(:gets).and_return(player_name)
        allow(game).to receive(:choice_input).and_return(player_symbol)
        allow(Player).to receive(:new).and_return(player_name, player_symbol)
      end

      it 'creates the first player' do
        game.create_player(1)
      end
    end

    context 'when second player is created' do
      before do
        player_name = 'dave'
        player_symbol = 'o'

        allow(game).to receive(:puts)
        allow(game).to receive(:create_player).with(2)
        allow(game).to receive(:gets).and_return(player_name)
        allow(game).to receive(:choice_input).and_return(player_symbol)
        allow(Player).to receive(:new).and_return(player_name, player_symbol)
      end
      it 'creates the second player' do
        game.create_player(2)
      end
    end
  end

  describe '#play_turns' do
    let(:game) { described_class.new }
    first_player = Player.new('john', 'x')
    second_player = Player.new('dave', 'o')
    context 'when game is playing' do
      before do
        allow(game).to receive(:current_player).and_return(first_player)
        allow(game.board).to receive(:full?).and_return(false)
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('1')
        allow(game).to receive(:turn).and_return(1)
      end

      it 'sets current player as first player' do
        allow(game.board).to receive(:game_over?).and_return(true)
        expect(game.current_player.name).to eq('john')
        game.play_turns
      end

      it 'sets current player as second player' do
        allow(game.board).to receive(:game_over?).and_return(false)
        allow(game).to receive(:current_player).and_return(second_player)
        allow(game.board).to receive(:game_over?).and_return(true)
        expect(game.current_player.name).to eq('dave')
        game.play_turns
      end
    end
  end
end
