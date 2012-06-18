module ScheduleScraper
  module Pointstreak
    class Schedule < Nibbler
      include ScheduleScraper::Schedule

      POINT_STREAK_URL = "http://www.pointstreak.com/players/print/players-team-schedule.html"

      element 'table table:last' => :list do
        elements 'tr:not(.fields)' => :event_list, :with => Event
      end

      def self.fetch(options)
        parse html(options[:season], options[:team])
      end

      def events
        list.event_list.reject { |event| event.away_team.nil? }
      end

      private

      def self.html(season, team)
        open(source_url(season, team))
      end

      def self.source_url(season, team)
        "#{POINT_STREAK_URL}?teamid=#{team}&seasonid=#{season}"
      end

      def event_class
        ScheduleScraper::Pointstreak::Event
      end
    end
  end
end
