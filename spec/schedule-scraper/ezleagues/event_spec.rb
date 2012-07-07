require File.expand_path(File.join(File.dirname(__FILE__), '../../spec_helper'))

describe ScheduleScraper::EZLeagues::Event do
  let(:options) { EZ_OPTIONS }
  let(:fields) { [:home_team, :away_team, :date, :time, :rink] }
  let(:expected_values) do
    {
      :home_team => "007",
      :away_team => "The Schwartz",
      :date => "Tue-Sep 11",
      :time => "8:55 PM",
      :rink => "Pineville Ice House"
    }
  end

  before do
    VCR.use_cassette('schwartz_summer_2012') do
      @schedule = ScheduleScraper::EZLeagues::Schedule.fetch(options)
    end
  end

  subject() { @schedule.events.last }

  [:home_team, :away_team, :date, :time, :rink].each do |field|
    it "can find the #{field.to_s.gsub('_', ' ')}" do
      subject.send(field).wont_be_nil
    end
  end

  it "uses elements to define fields for csv" do
    klass = ScheduleScraper::EZLeagues::Event
    klass.send(:export_fields).must_equal expected_values.keys
  end

  it "returns a list of fields when you ask for csv" do
    subject.to_csv.must_equal expected_values.values
  end
end

