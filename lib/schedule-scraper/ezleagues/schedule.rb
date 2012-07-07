module ScheduleScraper
  module EZLeagues
    class Schedule < Nibbler
      include ScheduleScraper::Schedule

      element 'table#ctl00_C_Schedule1_GridView1' => :list do
        elements 'tr:not(.HeaderStyle)' => :event_list, :with => Event
      end

      def events
        list.event_list #.reject { |event| event.away_team.nil? }
      end

      private

      def event_class
        ScheduleScraper::EZLeagues::Event
      end
    end
  end
end

