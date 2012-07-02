module ScheduleScraper
  module Event
    module ClassMethods
      def export_fields
        self.rules.keys
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    def to_csv
      self.class.export_fields.collect do |field|
        self.send(field)
      end
    end

    def to_gcal
      [
        title,
        start_date,
        start_time,
        end_date,
        "",
        all_day?,
        description,
        "",
        private?
      ]
    end

    def to_ical(cal)
      cal.event do |event|
        event.summary     description
        event.dtstart     start_date_time
        event.dtend       end_date_time
        event.location    ""
      end
    end

    def to_h
      {
        :title => title,
        :start_date => start_date,
        :start_time => start_time,
        :end_date => end_date,
        :all_day => all_day?,
        :description => description
      }
    end
  end
end

