require 'ri_cal'

module ScheduleScraper
  module Schedule
    module ClassMethods
    end

    def self.included(base)
      base.extend ClassMethods
    end

    def to_csv
      CSV.generate do |csv|
        csv << event_class.export_fields
        events.each do |event|
          csv << event.to_csv
        end
      end
    end

    # def to_ical
    #   RiCal.Calendar do
    #     event do
    #       description "MA-6 First US Manned Spaceflight"
    #       dtstart     DateTime.parse("2/20/1962 14:47:39")
    #       dtend       DateTime.parse("2/20/1962 19:43:02")
    #       location    "Cape Canaveral"
    #       add_attendee "john.glenn@nasa.gov"
    #       alarm do
    #         description "Segment 51"
    #       end
    #     end
    #   end
    # end

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
