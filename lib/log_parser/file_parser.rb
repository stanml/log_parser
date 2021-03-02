# Takes a file and regex object and returns a hash
class FileParser
  def initialize(path, regex_parser = nil)
    raise ArgumentError if !regex_parser.nil? && !regex_parser.respond_to?(:parse_string)

    @path = path
    @regex_parser = regex_parser
  end

  def parse_file
    output = {}
    IO.foreach(@path) do |line|
      result = @regex_parser.parse_string(line)
      next if result.nil?

      key = result[:key].to_sym
      output[key].nil? ? output[key] = result[:values] : output[key].push(*result[:values])
    end
    output
  end
end
