module ScheduleScraper
  module Pointstreak
    class Schedule < Nibbler
      include ScheduleScraper::Schedule

      element 'table table:last' => :list do
        elements 'tr:not(.fields)' => :event_list, :with => Event
      end

      def events
        list.event_list.reject { |event| event.away_team.nil? }
      end

      private

      def event_class
        ScheduleScraper::Pointstreak::Event
      end
    end
  end
end
