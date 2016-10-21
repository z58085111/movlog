# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'OMDB specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
    c.filter_sensitive_data('<KEYWORD>') { CREDENTIALS[:keyword] }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE_1, record: :new_episodes
    @omdb_api = Movlog::OmdbApi.new
  end

  after do
    VCR.eject_cassette
  end

  it 'should get the IMDB ID of a movie' do
    movie = Movlog::Movie.find(@omdb_api, t: CREDENTIALS[:keyword])
    movie.imdb_id.length.must_be :>, 0
  end
end