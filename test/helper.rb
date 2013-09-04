ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require File.expand_path '../../lib/toggl_api.rb', __FILE__

def load_fixture(request)
  file = File.expand_path("../fixtures/#{request}.json",__FILE__)
  IO.read(file)
end
