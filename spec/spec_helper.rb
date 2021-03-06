# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/movlog'

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"

CASSETTE_FILE_1 = 'omdb_api'
CASSETTE_FILE_2 = 'skyscanner_api'
CASSETTE_FILE_3 = 'airbnb_api'
CASSETTE_FILE_4 = 'airports_api'

OMDB_KEYWORD = 'hobbit'

if File.file?('config/credentials.yml')
  credentials = YAML.load(File.read('config/credentials.yml'))
  ENV['AIRBNB_CLIENT_ID'] = credentials[:airbnb_client_id]
  ENV['SKY_API_KEY'] = credentials[:skyscanner_api_key]
  ENV['GEONAMES_USERNAME'] = credentials[:geonames_username]
  ENV['GOOGLEMAP_KEY'] = credentials[:googlemap_key]
end

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  c.filter_sensitive_data('<SKY_API_KEY>')  { ENV['SKY_API_KEY'] }
  c.filter_sensitive_data('<AIRBNB_CLIENT_ID>') { ENV['AIRBNB_CLIENT_ID'] }
  c.filter_sensitive_data('<GEONAMES_USERNAME>') { ENV['GEONAMES_USERNAME'] }
  c.filter_sensitive_data('<GOOGLEMAP_KEY>') { ENV['GOOGLEMAP_KEY'] }
end

RESULT_FILE_1 = "#{FIXTURES_FOLDER}/omdb_api_results.yml"
RESULT_FILE_2 = "#{FIXTURES_FOLDER}/skyscanner_api_results.yml"
RESULT_FILE_3 = "#{FIXTURES_FOLDER}/airbnb_api_results.yml"
RESULT_FILE_4 = "#{FIXTURES_FOLDER}/airports_api_results.yml"
