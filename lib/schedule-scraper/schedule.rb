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
  end
end
