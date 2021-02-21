require_relative '../../lib/log_parser/aggregate_views.rb'

describe AggregateViews do
	describe '#aggregate_views' do
		context 'when no unique parameter is given' do
			let(:data) { { test_a: [1, 1, 2], test_b: [3, 3, 6] } }
			let(:result) { [[:test_a, 3], [:test_b, 3]] }

			it 'returns sorted count of non-unique values' do
				expect(described_class.aggregate(data)).to eq(result)
			end
		end

		context 'when no unique parameter is given as false' do
			let(:data) { { test_a: [1, 1, 2], test_b: [3, 3, 6] } }
			let(:result) { [[:test_a, 3], [:test_b, 3]] }

			it 'returns sorted count of non-unique values' do
				expect(described_class.aggregate(data, false)).to eq(result)
			end
		end

		context 'when no unique parameter is given as true' do
			let(:data) { { test_a: [1, 1, 2], test_b: [3, 3, 6] } }
			let(:result) { [[:test_a, 2], [:test_b, 2]] }

			it 'returns sorted count of non-unique values' do
				expect(described_class.aggregate(data, true)).to eq(result)
			end
		end
	end
end
