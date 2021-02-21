require_relative '../../lib/log_parser/regex_parser.rb'

describe RegexParser do
	describe '#parse_string' do
		let(:key_regex) { /\/.*?\s+/ }
		let(:value_regexs) { [/\d{1,3}\.\d{1,3}/] }
		let(:parser) { described_class.new(key_regex, value_regexs) }

		context 'when key value expressions are initialized' do
			let(:string) { '/test/1 123.456' }
			let(:result) { {key: '/test/1', values: ['123.456'] } }

			it 'returns hash with key and values' do
				expect(parser.parse_string(string)).to eq(result)
			end
		end

		context 'when multiple value expressions are initialized' do
			let(:value_regexs) { [/\d{1,3}\.\d{1,3}/, /multiple_test/] }
			let(:parser) { described_class.new(key_regex, value_regexs) }
			let(:string) { '/test/1 multiple_test 123.456' }
			let(:result) { {key: '/test/1', values: ['123.456', 'multiple_test'] } }

			it 'returns hash with key and values' do
				expect(parser.parse_string(string)).to eq(result)
			end
		end

		context 'when no patterns are found' do
			let(:string) { 'testing this will not work' }

			it 'returns nil' do
				expect(parser.parse_string(string)).to eq(nil)
			end
		end
	end
end
