module ScheduleScraper
  module Event
    module ClassMethods
      def export_fields
        self.rules.keys
      end

      def cleaner; lambda { |value| value.text.strip }; end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    def title
      "#{home_team} vs. #{away_team}"
    end

    def all_day?
      false
    end

    def description
      title
    end

    def start_date
      Date.parse(date).strftime(date_format)
    end

    def end_date
      start_date
    end

    def start_time
      begin
        Time.parse(time)
        time
      rescue
        # looks like an invalid time
        "12:00 PM"
      end
    end

    # def end_time
    #   will default to one hour?
    # end

    def start_date_time
      DateTime.strptime "#{start_date} #{start_time}", '%m/%d/%y %H:%M %P'
    end

    def end_date_time
      # default to 1 hr
      start_date_time.to_time + 3600
    end

    def date_time_string(dt)
      dt.strftime "%Y%m%dT%H%M%S"
    end

    def private?
      true
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
        event.dtstart     date_time_string(start_date_time)
        event.dtend       date_time_string(end_date_time)
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

