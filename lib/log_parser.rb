require_relative './log_parser/aggregate_views'
require_relative './log_parser/regex_parser'
require_relative './log_parser/file_parser'

URL_REGEX = %r{/.*?\s+}.freeze
IP_REGEX = /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/.freeze

path = ARGV[0]
return unless path.is_a?(String)

regex_parser = RegexParser.new(URL_REGEX, Array.new(1, IP_REGEX))
views_hash = FileParser.new(ARGV[0], regex_parser).parse_file

page_views = AggregateViews.aggregate(views_hash)
unique_page_views = AggregateViews.aggregate(views_hash, unique: true)

page_views.each { |page, views| puts "#{page} #{views} visits" }
unique_page_views.each { |page, views| puts "#{page} #{views} unique visits" }
