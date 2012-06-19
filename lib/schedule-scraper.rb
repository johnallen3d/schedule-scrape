require 'nibbler'
require 'open-uri'
require 'csv'
require 'uri'
require "schedule-scraper/version"
require "schedule-scraper/event"
require "schedule-scraper/schedule"
require "schedule-scraper/pointstreak/event"
require "schedule-scraper/pointstreak/schedule"

module ScheduleScraper
  def self.fetch(type, url)
    raise UnsupportedSchedule unless supported_schedules.include?(type.to_sym)
    raise InvalidURL unless valid_url?(url)

    type_class(type).fetch(url)
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

  def self.valid_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end

  class UnsupportedSchedule < StandardError; end
  class InvalidURL < StandardError; end
end
