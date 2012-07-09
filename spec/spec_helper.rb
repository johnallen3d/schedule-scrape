require 'minitest/spec'
require 'minitest/autorun'
require 'turn/autorun'
require 'vcr'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/schedule-scraper'))

POINTSTREAK_OPTIONS = "http://www.pointstreak.com/players/print/players-team-schedule.html?teamid=385368&seasonid=9162"
EZ_OPTIONS = "http://pinevilleice.ezleagues.ezfacility.com/teams/1026121/The-Schwartz.aspx"

class EventTest
  include ScheduleScraper::Event
  attr_accessor :time

  def self.export_fields
    [:home_team, :away_team]
  end

  def home_team; "home team"; end
  def away_team; "away team"; end
  def date; "01/01/2013"; end
  def date_format; "%m/%d/%y"; end
  def time; @time ||= "09:00 PM"; end
end

module ScheduleScraper
  class ScheduleTest
    include ScheduleScraper::Schedule

    def self.fetch(url)
      new()
    end

    def events
      (1..10).collect { EventTest.new }
    end

    def event_class
      EventTest
    end
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :fakeweb
end
