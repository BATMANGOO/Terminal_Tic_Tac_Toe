require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    let(:player) { described_class.new('john', 'x') }
    context 'player is intialized' do
      it 'returns player name' do
        expect(player.name).to eq('john')
      end

      it 'returns player choice' do
        expect(player.choice).to eq('x')
      end
    end
  end
end