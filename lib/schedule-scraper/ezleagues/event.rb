module ScheduleScraper
  module EZLeagues
    class Event < Nibbler
      include ScheduleScraper::Event

      element 'td:nth(2)' => :home_team, :with => cleaner
      element 'td:nth(4)' => :away_team, :with => cleaner
      element 'td:first a'  => :date, :with => cleaner
      element 'td:nth(5)' => :time, :with => cleaner
      element 'td:nth(6)' => :rink, :with => cleaner

      def date_format
        "%m/%d/%y"
      end
    end
  end
end
