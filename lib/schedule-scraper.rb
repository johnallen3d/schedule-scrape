require 'nibbler'
require 'open-uri'
require 'csv'
require "schedule-scraper/version"
require "schedule-scraper/event"
require "schedule-scraper/schedule"
require "schedule-scraper/pointstreak/event"
require "schedule-scraper/pointstreak/schedule"

module ScheduleScraper
  def self.fetch(type, options = {})
    raise UnsupportedSchedule unless supported_schedules.include?(type.to_sym)

    type_class(type).fetch(options)
  end

  def self.type_class(type)
    case type
    when :pointstreak then Pointstreak::Schedule
    end
  end

  def self.supported_schedules
    [
      :pointstreak
    ]
  end

  class UnsupportedSchedule < StandardError; end
end
