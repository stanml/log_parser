# Extracts information from a string using multuple regular expressions
class RegexParser
  def initialize(key, values = [])
    @key = key
    @values = values
  end

  def parse_string(string)
    key = match_key(string)
    values = match_values(string)
    return unless !key.nil? && values.all?

    { key: key.strip, values: values }
  end

  private

  def match_values(string)
    @values.map do |value|
      matched_value = string.match(value)
      nil_check(matched_value)
    end
  end

  def match_key(string)
    matched_key = string.match(@key)
    nil_check(matched_key)
  end

  def nil_check(match_result)
    match_result[0] unless match_result.nil?
  end
end
