require File.expand_path(File.join(File.dirname(__FILE__), '../../spec_helper'))

describe ScheduleScraper::EZLeagues::Schedule do
  subject() { ScheduleScraper::EZLeagues::Schedule }
  let(:options) { EZ_OPTIONS }

  describe "schedule instance" do
    subject() do
      VCR.use_cassette('schwartz_summer_2012') do
        ScheduleScraper::EZLeagues::Schedule.fetch(options)
      end
    end

    it "returns an instance of itself" do
      subject.must_be_instance_of ScheduleScraper::EZLeagues::Schedule
    end

    it "finds an event list" do
      subject.list.wont_be_nil
    end

    it "has a list of events" do
      subject.events.must_be_instance_of Array
      subject.events.length.must_equal 13
    end
  end
end


