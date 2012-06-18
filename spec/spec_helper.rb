require 'minitest/spec'
require 'minitest/autorun'
require 'turn/autorun'
require 'vcr'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/schedule-scraper'))

POINTSTREAK_OPTIONS = { :season => "9162", :team => "385368" }

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :fakeweb
end
