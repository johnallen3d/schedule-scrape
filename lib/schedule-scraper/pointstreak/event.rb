module ScheduleScraper
  module Pointstreak
    class Event < Nibbler
      include ScheduleScraper::Event

      element 'td:first' => :home_team, :with => cleaner
      element 'td:nth(2)' => :away_team, :with => cleaner
      element 'td:nth(3)' => :date, :with => cleaner
      element 'td:nth(4)' => :time, :with => cleaner
      element 'td:nth(5)' => :rink, :with => cleaner

      def start_date
        Date.parse(date).strftime("%m/%d/%y")
      end
    end
  end
end

