require File.expand_path(File.join(File.dirname(__FILE__), '../../spec_helper'))

describe ScheduleScraper::Pointstreak::Event do
  let(:options) { POINTSTREAK_OPTIONS }
  let(:fields) { [:home_team, :away_team, :date, :time, :rink] }

  before do
    VCR.use_cassette('summit_summer_2012') do
      @schedule = ScheduleScraper::Pointstreak::Schedule.fetch(options)
    end
  end

  subject() { @schedule.events.first }

  [:home_team, :away_team, :date, :time, :rink].each do |field|
    it "can find the #{field.to_s.gsub('_', ' ')}" do
      subject.send(field).wont_be_nil
    end
  end

  it "uses elements to define fields for csv" do
    klass = ScheduleScraper::Pointstreak::Event
    klass.send(:export_fields).must_equal fields
  end

  it "returns a list of fields when you ask for csv" do
    expected = ["BLADES 6", "SUMMIT 8", "Sun, Jun 03", "7:45 pm", "final"]
    subject.to_csv.must_equal expected
  end
end
