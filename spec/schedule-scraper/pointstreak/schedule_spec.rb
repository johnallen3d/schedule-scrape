require File.expand_path(File.join(File.dirname(__FILE__), '../../spec_helper'))

describe ScheduleScraper::Pointstreak::Schedule do
  subject() { ScheduleScraper::Pointstreak::Schedule }
  let(:options) { POINTSTREAK_OPTIONS }

  describe "schedule instance" do
    subject() do
      VCR.use_cassette('summit_summer_2012') do
        ScheduleScraper::Pointstreak::Schedule.fetch(options)
      end
    end

    it "returns an instance of itself" do
      subject.must_be_instance_of ScheduleScraper::Pointstreak::Schedule
    end

    it "finds an event list" do
      subject.list.wont_be_nil
    end

    it "has a list of events" do
      subject.events.must_be_instance_of Array
      subject.events.length.must_equal 8
    end
  end
end
