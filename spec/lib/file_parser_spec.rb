require_relative '../../lib/log_parser/regex_parser.rb'
require_relative '../../lib/log_parser/file_parser.rb'

describe FileParser do
	describe '#initialize' do
		context 'when arguments contain incorrect regex_parser class' do
			it 'raises an argument error' do
				expect{ described_class.new('', '') }.to raise_error(ArgumentError)
			end
		end
	end	

	describe '#parse_file' do
		context 'when a file path and parser are supplied' do
			let(:path) { './spec/fixtures/test.log' }
			let(:regex_parser) { RegexParser.new(/test_argument.*?\s/, [/test_pattern.*/]) }
			let(:file_parser) { described_class.new(path, regex_parser) }
			let(:result) do 
				{ 
					test_argument_1: ['test_pattern_a', 'test_pattern_d'],
					test_argument_2: ['test_pattern_b', 'test_pattern_e'],
					test_argument_3: ['test_pattern_c']
				}
			end

			it 'parses file, skips unmatched lines and returns correct hash structure'do
				expect(file_parser.parse_file).to eq(result)
			end
		end
	end	
end
