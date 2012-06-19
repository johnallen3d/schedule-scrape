require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe ScheduleScraper do
  subject() { ScheduleScraper }
  let(:options) { POINTSTREAK_OPTIONS }

  describe ".fetch" do
    it "validates requested schedule type" do
      VCR.use_cassette('summit_summer_2012') do
        ScheduleScraper.fetch(:pointstreak, options) # wont_raise
      end

      -> {
        ScheduleScraper.fetch(:xyz, options)
      }.must_raise ScheduleScraper::UnsupportedSchedule
    end

    it "validates the url" do
      -> {
        ScheduleScraper.fetch(:pointstreak, "abc")
      }.must_raise ScheduleScraper::InvalidURL
    end

    it "returns a schedule" do
      VCR.use_cassette('summit_summer_2012') do
        schedule = ScheduleScraper.fetch(:pointstreak, options)
        schedule.must_be_instance_of ScheduleScraper::Pointstreak::Schedule
      end
    end
  end
end
