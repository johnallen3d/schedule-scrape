require 'date'
require 'ri_cal'

module ScheduleScraper
  module Schedule
    module ClassMethods
    end

    def self.included(base)
      base.extend ClassMethods
    end

    def to_h
      [].tap do |list|
        events.each do |event|
          list << event.to_h
        end
      end
    end

    def to_csv
      CSV.generate do |csv|
        csv << event_class.export_fields
        events.each do |event|
          csv << event.to_csv
        end
      end
    end

    def to_ical
      # inside RiCal block events are not available
      local_events = events

      RiCal.Calendar do |cal|
        local_events.each do |local_event|
          local_event.to_ical(cal)
        end
      end
    end

    def to_gcal
      headers = [
        "Subject",
        "Start Date",
        "Start Time",
        "End Date",
        "End Time",
        "All Day Event",
        "Description",
        "Location",
        "Private"
      ]

      CSV.generate do |csv|
        csv << headers
        events.each do |event|
          csv << event.to_gcal
        end
      end
    end

    def to_ycal
      headers = %w(name start_date start_time end_date end_time venue_name venue_location category_id description ticket_price ticket_free ticket_url event_url personal)

      CSV.generate do |csv|
        csv << headers
        events.each do |event|
          csv << event.to_ycal
        end
      end
    end
  end
end
