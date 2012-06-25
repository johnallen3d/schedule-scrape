module ScheduleScraper
  module Pointstreak
    class Event < Nibbler
      include ScheduleScraper::Event

      cleaner = lambda { |value| value.text.strip }

      element 'td:first' => :home_team, :with => cleaner
      element 'td:nth(2)' => :away_team, :with => cleaner
      element 'td:nth(3)' => :date, :with => cleaner
      element 'td:nth(4)' => :time, :with => cleaner
      element 'td:nth(5)' => :rink, :with => cleaner

      def title
        "#{home_team} vs. #{away_team}"
      end

      def start_date
        Date.parse(date).strftime("%m/%d/%y")
      end

      def end_date
        start_date
      end

      def start_time
        time
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

      def all_day?
        false
      end

      def description
        title
      end

      def private?
        true
      end
    end
  end
end

