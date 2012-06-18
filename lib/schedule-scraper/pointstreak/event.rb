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
    end
  end
end

