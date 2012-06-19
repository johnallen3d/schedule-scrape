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
  end
end

