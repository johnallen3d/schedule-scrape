require File.expand_path(File.join(File.dirname(__FILE__), '../../spec_helper'))

describe ScheduleScraper::Pointstreak::Schedule do
  subject() { ScheduleScraper::Pointstreak::Schedule }
  let(:options) { POINTSTREAK_OPTIONS }

  it "knows the root pointstreak url" do
    subject::POINT_STREAK_URL.must_match /pointstreak/
  end

  it "builds a valid url" do
    url = subject.send(:source_url, "123", "456")
    expected = "#{subject::POINT_STREAK_URL}?teamid=456&seasonid=123"

    url.must_equal expected
  end

  it "fetches html from pointstreak" do
    VCR.use_cassette('summit_summer_2012') do
      subject.html(options[:season], options[:team])
    end # wont_raise
  end

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

    it "generates a csv file" do
      subject.to_csv.must_be_instance_of String
    end
  end
end
